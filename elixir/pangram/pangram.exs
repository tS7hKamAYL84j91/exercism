defmodule Pangram do

  @alphabet ?a..?z 

  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t) :: boolean
  def pangram?(sentence) do
    @alphabet 
    |> Enum.to_list
    |> Kernel.--(
      sentence
      |> String.downcase #normalise letters
      |> to_charlist)
    |> Enum.empty? 
  end
end
