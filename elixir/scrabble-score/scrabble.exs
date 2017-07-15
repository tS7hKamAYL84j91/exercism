defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
   @letter_score [{["A", "E", "I", "O", "U", "L", "N", "R", "S", "T" ], 1},
    {["D","G"], 2},
    {["B", "C", "M", "P"] , 3},
    {["F", "H", "V", "W", "Y" ], 4},
    {["K"], 5},
    {["J", "X"], 8},
    {["Q", "Z"], 10}]

  @spec score(String.t) :: non_neg_integer
  def score(word), do: word |> String.upcase |> String.codepoints |> Enum.reduce(0,&(&1 |> letter_score |> Kernel.+(&2))) 
  
  for {letter, score} <- (for {k,v} <- @letter_score do  k |> Enum.map(&{&1,v}) end |> List.flatten) do
    def letter_score(unquote(letter)), do: unquote(score)
  end
  
  def letter_score(_), do: 0

end