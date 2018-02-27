defmodule RailFenceCipher do
  require Integer
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t(), pos_integer) :: String.t()
  def encode(str, rails), do: str |> encoder(rails, &zigzag/2)

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t(), pos_integer) :: String.t()
  def decode(str, rails), do: str |> encoder(rails, &inv_zigzag(&1,&2, String.length(str)-1 ))


  # Common encoding and decoding tasks
  defp encoder(str, rails, sort_fn), do: str |> String.codepoints |> Enum.with_index |> Enum.sort_by(&sort_fn.(&1, rails)) |> Enum.map_join("", &elem(&1, 0))

  # Allocates position x to a rail in a zigzag with a helper to take tuple
  defp zigzag(_, 1), do: 0
  defp zigzag({_l, x}, r) when rem(x, (r-1)*2) > r-1, do: (r-1)*2-rem(x, (r-1)*2)
  defp zigzag({_l, x}, r), do: rem(x, (r-1)*2)

  # Calculates original position based on current zigzag position (inverse of zigzag)
  defp inv_zigzag({_l, x}, r, l), do: 0..l |> Enum.sort_by(&zigzag({nil, &1}, r)) |> Enum.at(x)

end
