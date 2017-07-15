defmodule Scrabble do
  #require ScrabbleScoreMaker
  @doc """
  Calculate the scrabble score for the word.
  """
  @letter_scores %{
    ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T" ] => 1,
    ["D","G"] => 2,
    ["B", "C", "M", "P"] => 3,
    ["F", "H", "V", "W", "Y" ] => 4,
    ["K"] => 5,
    ["J", "X"] => 8,
    ["Q", "Z"] => 10
  }


  @spec score(String.t) :: non_neg_integer
  def score(word) do
    word 
    |> String.upcase 
    |> String.codepoints
    |> Enum.map(&letter_score/1)
    |> Enum.sum 
  end

  @spec letter_score(String.t) :: non_neg_integer
  def letter_score(letter), do:  @letter_scores |> Map.get(letter |> letter_score_key, 0)
  
  @spec letter_score_key(String.t) :: [String.t]
  def letter_score_key(letter), do: @letter_scores |> Map.keys |> Enum.map(&({letter in &1, &1})) |> Keyword.get(true)


end