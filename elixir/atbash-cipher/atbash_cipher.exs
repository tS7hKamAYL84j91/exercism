defmodule Atbash do
  @trad_group_size 5
  @alphabet ?a..?z
  
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t) :: String.t
  def encode(plaintext), do: plaintext |> encoder |> Enum.chunk_every(@trad_group_size) |> Enum.join(" ")

  @spec decode(String.t) :: String.t
  def decode(cipher), do: cipher |> encoder |> to_string

  defp encoder(pt), do:  pt |> String.replace(~r/[^\p{Xan}]/, "") |> String.downcase |> to_charlist |> Enum.map(&encode_letter(&1)) 
  
  defp encode_letter(c) when c in @alphabet, do: ?a + ?z - c
  defp encode_letter(c), do: c

end
