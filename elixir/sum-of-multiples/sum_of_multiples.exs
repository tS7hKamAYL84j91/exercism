defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    factors 
    |> Enum.map(&multiples(&1,limit)) 
    |> List.flatten 
    |> Enum.uniq
    |> Enum.sum
  end

  defp multiples(f, l), do: Stream.iterate(f, &(&1+f))|> Enum.take_while(&(&1<l))

end
