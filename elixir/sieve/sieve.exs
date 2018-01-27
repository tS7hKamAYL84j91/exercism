defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  Create lazy sequence 2..∞ and use transform to reduce the sequence using the prime sieve
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do 
    Stream.iterate(2, &(&1+1)) 
    |> Stream.transform([], &prime_sieve/2) 
    |> Stream.take_while(&(&1<=limit)) 
    |> Enum.to_list
  end
  
  #Reducer that checks if number is prime by dividing it by all primes less than it's sqrt
  defp prime_sieve(x, acc) do 
    acc 
    |> Enum.drop_while(&(&1 > x |> :math.sqrt |> round |> Kernel.+(1)))  
    |> Enum.map(&rem(x, &1)) 
    |> Enum.any?(&(&1==0)) 
    |> (fn  true  -> {[], acc} 
            false -> {[x], [x|acc]} 
        end).()
  end 

end
