defmodule ISBNVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> ISBNVerifier.isbn?("3-598-21507-X")
      true

      iex> ISBNVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn), do: validate_chrs(isbn) and validate_check_sum(isbn)

  defp validate_chrs(isbn), do: isbn =~ ~r/^(\d-?){9}(\d|X)$/

  defp validate_check_sum(isbn) do
    isbn
    |> String.replace("-", "")
    |> String.codepoints()
    |> Enum.map(&to_integer/1)
    |> Enum.zip(10..1)
    |> Enum.reduce(0, &validate_check_sum/2)
  end

  defp validate_check_sum({x, 1}, acc), do: rem(x + acc, 11) == 0
  defp validate_check_sum({x, m}, acc), do: acc + x * m

  defp to_integer("X"), do: 10
  defp to_integer(x), do: x |> String.to_integer()

end
