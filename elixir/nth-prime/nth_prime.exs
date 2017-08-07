defmodule Prime do
  @primes [2]

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(n) when n >= 1, do: Stream.iterate(@primes, &next_prime/1) |> Stream.map(&hd/1) |> Enum.at(n-1)
  
  defp next_prime(xs) do
    xs
    |> Enum.max
    |> Stream.iterate(&(&1+1)) 
    |> Stream.drop_while(&!Prime.is_prime?(&1,xs)) 
    |> Enum.take(1)
    |> Kernel.++(xs)
  end
 
  defp is_prime?(x, primes), do: primes |> Enum.all?(&(rem(x,&1))!=0)


end
