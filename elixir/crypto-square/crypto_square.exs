defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t) :: String.t
  def encode(""), do: ""
  def encode(str), do: str |> normalise |> to_matrix |> columns |> Enum.map(&Enum.join(&1,"")) |> Enum.join(" ")

  defp normalise(str), do: str |> String.replace(~r/[^\w]/, "") |> String.downcase

  defp to_matrix(str), do: str |>  to_matrix(str |> String.length |> :math.sqrt |> Float.ceil |> trunc)
  defp to_matrix(str, c), do:  str |> String.codepoints |> Enum.chunk_every(c)

  defp columns(xss), do: 0..(xss |> hd |> length |> Kernel.-(1)) |> Enum.map(&column(xss, &1))  
  
  defp column(xss, c), do: xss |> Enum.map(&Enum.at(&1, c)) 

end
