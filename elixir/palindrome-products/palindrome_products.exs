defmodule Palindromes do

  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1), do: min_factor |> palidrome_pairs(max_factor) |> Enum.group_by(&product/1)

  defp product([x1,x2]), do: x1 * x2

  defp palidrome_pairs(min,max), do: for x <- min..max, y <- x..max, is_palidrome?(x*y), do: [x,y] 

  defp is_palidrome?(x) when x |> is_integer, do: x |> Integer.digits |> is_palidrome?  
  defp is_palidrome?(xs) when xs |> is_list, do: xs  == xs |> Enum.reverse

end
