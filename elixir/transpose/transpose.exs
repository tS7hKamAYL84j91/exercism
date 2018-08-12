Code.load_file("../matrix/matrix.exs", __DIR__)

defmodule Transpose do
  @doc """
  Given an input text, output it transposed.

  Rows become columns and columns become rows. See https://en.wikipedia.org/wiki/Transpose.

  If the input has rows of different lengths, this is to be solved as follows:
    * Pad to the left with spaces.
    * Don't pad to the right.

  ## Examples
  iex> Transpose.transpose("ABC\nDE")
  "AD\nBE\nC"

  iex> Transpose.transpose("AB\nDEF")
  "AD\nBE\n F"
  """

  @spec transpose(String.t()) :: String.t()
  def transpose(""), do: ""
  def transpose(input) do 
    input 
    |> Matrix.from_string(:string, "") 
    |> Matrix.columns
    |> Enum.map(&Enum.map(&1, fn nil -> " "; x -> x end))
    |> Enum.map(&Enum.join(&1, ""))
    |> Enum.join("\n")
    |> String.trim
  end

end
