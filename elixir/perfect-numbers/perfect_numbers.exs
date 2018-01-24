defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: ({ :ok, atom } | { :error, String.t() })
  def classify(x) when x > 0, do: {:ok, x |> aliquot_sum |> classify(x)}
  def classify(_), do: {:error, "Classification is only possible for natural numbers."}
  
  defp classify(as, as), do: :perfect
  defp classify(as, x) when x < as, do: :abundant
  defp classify(_as, _x), do: :deficient 

  defp aliquot_sum(1), do: 0
  defp aliquot_sum(x), do: 1..x-1 |> Enum.filter(&(rem(x,&1)==0)) |> Enum.sum

end

