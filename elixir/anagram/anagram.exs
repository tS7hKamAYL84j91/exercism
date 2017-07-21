defmodule Anagram do
  @doc """
  Returns all candidates (ts) that are anagrams of, but not equal to, 'base' (b).
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(b, ts), do: ts |> Enum.filter(&(anagram? b, &1))
  
  defp anagram?(b, t), do: t |> String.downcase != b |> String.downcase and t |> sort_chars == b |> sort_chars
  defp sort_chars(t), do: t |> String.downcase |> String.codepoints |> Enum.sort  
end
