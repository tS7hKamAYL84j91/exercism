defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase 
    |> String.split("\s")
    |> Enum.map(&translate_word(&1,:string))
    |> Enum.join("\s")
  end

  @spec translate_word(word :: String.t(),atom) :: String.t()
  defp translate_word(word, :string), do: word|> to_charlist |> translate_word |> to_string
  
  @spec translate_word(word :: [char]) :: [char]
  defp translate_word([a|_]=word) when a in [?a, ?e, ?i, ?o, ?u], do: word ++ [?a,?y]
  defp translate_word([a,b,c|t]) when [a,b,c] in ['squ', 'thr', 'sch'], do: t ++ [a,b,c,?a,?y]
  defp translate_word([a,b|t]) when [a,b] in ['ch', 'qu', 'th'], do: t ++ [a,b,?a,?y]
  defp translate_word([a,b|_]=word) when [a,b] in ['yt', 'xr'], do: word ++ [?a,?y]
  defp translate_word([a|t]) when not(a in [?a, ?e, ?i, ?o, ?u]), do: t ++ [a,?a,?y]
  defp translate_word(word), do:  word

end

