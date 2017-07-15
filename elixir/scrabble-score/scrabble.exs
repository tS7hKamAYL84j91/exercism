defmodule ScrabbleScoreMaker do
  defmacro letter_scores(scores) do
    scores 
    |> Enum.map(fn {k,v} -> Enum.map(k, &{&1,v})  end) 
    |> List.flatten 
    |> Enum.map(fn {letter, score} -> 
        quote do
          def letter_score(unquote(letter)), do: unquote(score)
        end
      end)
    |> Kernel.++([(quote do  def letter_score(_), do: 0 end)])
  end
end

defmodule Scrabble do
  require ScrabbleScoreMaker
  @doc """
  Calculate the scrabble score for the word.
  """
  ScrabbleScoreMaker.letter_scores([
    {["A", "E", "I", "O", "U", "L", "N", "R", "S", "T" ], 1},
    {["D","G"], 2},
    {["B", "C", "M", "P"] , 3},
    {["F", "H", "V", "W", "Y" ], 4},
    {["K"], 5},
    {["J", "X"], 8},
    {["Q", "Z"], 10}
  ])

  @spec score(String.t) :: non_neg_integer
  def score(word),do:  word |> String.upcase |> String.codepoints |> Enum.map(&letter_score/1) |> Enum.sum 


end