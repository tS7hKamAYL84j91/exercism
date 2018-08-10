defmodule OCRNumbers do
  @digits %{
    [" _ ", "| |", "|_|", "   "] => "0",
    ["   ", "  |", "  |", "   "] => "1",
    [" _ ", " _|", "|_ ", "   "] => "2",
    [" _ ", " _|", " _|", "   "] => "3",
    ["   ", "|_|", "  |", "   "] => "4",
    [" _ ", "|_ ", " _|", "   "] => "5",
    [" _ ", "|_ ", "|_|", "   "] => "6",
    [" _ ", "  |", "  |", "   "] => "7",
    [" _ ", "|_|", "|_|", "   "] => "8",
    [" _ ", "|_|", " _|", "   "] => "9"
  }

  @col_error {:error, 'invalid column count'}
  @row_error {:error, 'invalid line count'}

  @doc """
  Given a 3 x 4 grid of pipes, underscores, and spaces, determine which number is represented, or
  whether it is garbled.
  """
  @spec convert([String.t()]) :: String.t()
  def convert(input) do
    with {:ok, validated_input} <- input |> validate_input do
      {:ok, validated_input |> parse_input |> to_digits}
    else
      err -> err
    end
  end

  def validate_input(input) when rem(length(input), 4) != 0, do: @row_error

  def validate_input(input) do
    input
    |> Enum.map(&split_input_line/1)
    |> Enum.map(&List.last/1)
    |> Enum.reduce_while({:ok, input}, &validate_columns/2)
  end

  def split_input_line(line), do: line |> String.codepoints() |> Enum.chunk_every(3)

  def validate_columns(line, _acc) when length(line) != 3, do: {:halt, @col_error}
  def validate_columns(_line, acc), do: {:cont, acc}

  def parse_input({:error, _} = error), do: error

  def parse_input(input), do: input |> Enum.chunk_every(4) |> Enum.map(&parse_line/1)

  def parse_line(line) do
    line
    |> Enum.map(&split_input_line/1)
    |> columns
    |> Enum.map(fn x -> Enum.map(x, &Enum.join(&1, "")) end)
  end

  def columns(input), do: 0..cols(input) |> Enum.map(&column(input, &1))
  def column(input, index), do: input |> Enum.map(&Enum.at(&1, index))
  def cols(input), do: (input |> hd |> length) - 1

  def to_digits({:error, _} = error), do: error

  def to_digits(input) do
    input
    |> Enum.map(fn row -> row |> Enum.map(&convert_digit/1) |> Enum.join("") end)
    |> Enum.join(",")
  end

  for {ocr, digit} <- @digits do
    def convert_digit(unquote(ocr)), do: unquote(digit)
  end

  def convert_digit(_), do: "?"
end
