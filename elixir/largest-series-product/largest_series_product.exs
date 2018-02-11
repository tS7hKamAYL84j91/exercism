defmodule Series do

  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t, non_neg_integer) :: non_neg_integer
  def largest_product(xs, s), do: xs |> String.codepoints |> Enum.map(&String.to_integer/1) |> calc_product(s)
  
  defp calc_product(_, 0), do: 1
  defp calc_product(xs, s) when s > length(xs) or s < 0, do: raise(ArgumentError, message: "Oops")
  defp calc_product(xs, s), do: xs |> Enum.chunk_every(s, 1, :discard) |> Enum.reduce(0, &max_product/2)

  defp max_product(xs, acc), do: xs |> Enum.reduce(&Kernel.*/2) |> Kernel.max(acc)

end
Enu