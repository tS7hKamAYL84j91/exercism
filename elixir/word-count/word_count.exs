defmodule Words do
  @type sentence :: String.t
  @type word :: String.t
  @type words :: [word]
  @type word_count :: %{word => number}

  @doc """
  Count the number of words in the sentence.
  Words are compared case-insensitively.

  Refactored based on cthree's solution
  """
  @spec count(sentence) :: word_count
  def count(sentence) do
    sentence
    |> split_sentence
    |> Enum.reduce(%{}, &word_count/2)
  end

  @spec split_sentence(sentence) :: words
  def split_sentence(sentence), do: Regex.split(~r/[^-[:alnum:]]/u,  sentence |> String.downcase, trim: true)

  @spec word_count(word, word_count) :: word_count
  def word_count(word, word_count), do: Map.update(word_count, word, 1, &(&1+1))

end
