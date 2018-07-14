defmodule Forth do
  @input_patterns ~r/[0-9\-+*\/]+|\w+|\:.+?;/u
  @command_pattern ~r/\:.+?;/u
  @command_content ~r/(?!\:)(.+)?(?=;)/u

  @opaque evaluator :: any

  @doc """
  Create a new evaluator.
  """
  @spec new() :: evaluator
  def new(), do: [commands: %{}, stack: []]

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  @spec eval(evaluator, String.t()) :: evaluator
  def eval(ev, input_str),
    do:
      with(
        [commands: cmds, pre_process_input_str: pp_input_str] <-
          input_str |> pre_process_commands(ev[:commands]),
        do: [commands: cmds, stack: pp_input_str |> tokenise |> evaluate_stack(ev[:stack])]
      )

  def pre_process_commands(input_str, cmds) do
    input_str
    |> String.split(@command_pattern, include_captures: true, trim: true)
    |> Enum.map(&{&1, Regex.match?(@command_content, &1)})
    |> Enum.reduce([commands: cmds, pre_process_input_str: ""], &pre_process_cmds_reducer(&1, &2))
  end

  def pre_process_cmds_reducer(
        {input_str, true},
        commands: cmds,
        pre_process_input_str: full_input_str
      ) do
    with [new_cmd, replace_cmd] <- input_str |> extract_command do
      case new_cmd =~ ~r/^\d+$/ do
        false ->
          [commands: cmds |> Map.put(new_cmd, replace_cmd), pre_process_input_str: full_input_str]

        _ ->
          raise Forth.InvalidWord
      end
    end
  end

  def pre_process_cmds_reducer(
        {input_str, false},
        commands: cmds,
        pre_process_input_str: full_input_str
      ),
      do: [
        commands: cmds,
        pre_process_input_str: full_input_str <> (input_str |> apply_commands(cmds))
      ]

  def extract_command(input_str) do
    input_str
    |> String.slice(1, input_str |> String.length() |> Kernel.-(2))
    |> String.trim()
    |> String.split(" ", parts: 2)
  end

  def apply_commands(input_str, commands),
    do: commands |> Enum.reduce(input_str, fn {k, v}, acc -> String.replace(acc, k, v) end)

  def tokenise(input_str),
    do: @input_patterns |> Regex.scan(input_str |> String.downcase()) |> List.flatten()

  def evaluate_stack(tokens, eval_stack), do: tokens |> Enum.reduce(eval_stack, &stack_reducer/2)

  def stack_reducer("+", [t1, t2 | ev]), do: [t2 + t1 | ev]
  def stack_reducer("-", [t1, t2 | ev]), do: [t2 - t1 | ev]
  def stack_reducer("*", [t1, t2 | ev]), do: [t2 * t1 | ev]
  def stack_reducer("/", [0, _t2 | _]), do: raise(Forth.DivisionByZero)
  def stack_reducer("/", [t1, t2 | ev]), do: [div(t2, t1) | ev]
  def stack_reducer("dup", [t1 | ev]), do: [t1, t1 | ev]
  def stack_reducer("drop", [_t1 | ev]), do: ev
  def stack_reducer("swap", [t1, t2 | ev]), do: [t2, t1 | ev]
  def stack_reducer("over", [t1, t2 | ev]), do: [t2, t1, t2 | ev]
  def stack_reducer(t, [_t1]) when t in ~w/swap over/, do: raise(Forth.StackUnderflow)

  def stack_reducer(t, []) when t in ~w/\+ \- \* \/ dup drop swap over/,
    do: raise(Forth.StackUnderflow)

  def stack_reducer(t, ev) do
    case t =~ ~r/^\d+$/ do
      true -> [t |> String.to_integer() | ev]
      false -> raise(Forth.UnknownWord)
    end
  end

  @doc """
  Return the current full_input_str as a string with the element on top of the full_input_str
  being the rightmost element in the string.
  """
  @spec format_stack(evaluator) :: String.t()
  def format_stack(ev), do: ev[:stack] |> Enum.reverse() |> Enum.join(" ")

  defmodule StackUnderflow do
    defexception []
    def message(_), do: "full_input_str underflow"
  end

  defmodule InvalidWord do
    defexception word: nil
    def message(e), do: "invalid word: #{inspect(e.word)}"
  end

  defmodule UnknownWord do
    defexception word: nil
    def message(e), do: "unknown word: #{inspect(e.word)}"
  end

  defmodule DivisionByZero do
    defexception []
    def message(_), do: "division by zero"
  end
end
