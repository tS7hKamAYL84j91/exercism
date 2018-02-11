defmodule SimpleCipher do
  @alphabet ?a..?z
  @modulo @alphabet |> Enum.to_list |> length

  def encode(plaintext, key), do: plaintext |> transpose(key, :encode) |> to_string

  def decode(ciphertext, key), do: ciphertext |> transpose(key, :decode) |> to_string

  defp transpose(pt, key, scheme), do: pt |> String.downcase |> to_charlist |> Stream.zip(key |> to_charlist |> Stream.cycle) |> Enum.map(&transpose_char(&1, scheme))
  
  defp transpose_char({c,k}, :encode) when c in @alphabet, do: Integer.mod(k - (2 * ?a) + c, @modulo) + ?a # (k - ?a) + (c -?a) keep 0..26 in a ring and then move back to char
  defp transpose_char({c,k}, :decode) when c in @alphabet, do: Integer.mod(c - k, @modulo) + ?a # (c - ?a) - (k - ?a) 
  defp transpose_char({c,_}, _), do: c
  
end

