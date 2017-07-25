defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    str
    |> String.replace(~r/[^(\{\[)\}\]]/, "")  # strip out chars that aren't brackets
    |> String.codepoints                     
    |> Enum.reduce([], &bracket_stack/2)      # expect to be reduced to empty list
    |> Enum.empty?
  end


  defp bracket_stack("[", acc), do: ["]" | acc]     # push brackets onto stack
  defp bracket_stack("(", acc), do: [")" | acc]     
  defp bracket_stack("{", acc), do: ["}" | acc]     
  defp bracket_stack(x, [a|as]) when x == a, do: as # match bracket, pop stack
  defp bracket_stack(_x, _acc), do: [false]         # Closing bracket no opening ... ruin stack

end
