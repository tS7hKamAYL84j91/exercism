defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.
  ## Examples
  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {atom, non_neg_integer} | {atom, String.t}
  def hamming_distance(s1, s2) when length(s1) == length(s2), do: {:ok, s1 |> Enum.zip(s2) |> Enum.count(&diff_letter/1)}
  def hamming_distance(_s1, _s2), do: {:error, "Lists must be the same length"}

  defp diff_letter({a, a}), do: false
  defp diff_letter(_), do: true
                                              
  
end
