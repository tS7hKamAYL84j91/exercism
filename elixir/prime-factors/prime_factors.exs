defmodule PrimeFactors do
  @primes_seed [2,3]
  @doc """
  Compute the prime factorisation_test for 'number'.

  The prime factorisation_test are prime numbers that when multiplied give the desired
  number.

  The prime factorisation_test of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(x), do: x |> potential_factors |> Enum.reduce({x,[]}, &factorise/2) |> factorise |> Enum.reverse

  def potential_factors(x) do 
    Stream.iterate(0, &(&1+1)) 
    |> Stream.flat_map(&PrimeFactors.wheel(&1,@primes_seed))
    |> Stream.take_while(&(&1<= sqrt_plus_1(x))) 
    |>  Stream.filter(&(rem(x,&1) == 0))
  end
  
  defp factorise(p, {x, acc}) when rem(x,p) == 0, do: factorise(p, {div(x,p), [p|acc]}) # keep dividing by same factor
  defp factorise(_, {x, acc}), do: {x, acc}

  defp factorise({1,acc}), do: acc
  defp factorise({x,acc}), do: [x | acc]

  defp sqrt_plus_1(x), do: x |> :math.sqrt |> round |> Kernel.+(1) 


  #Wheel Factorisation https://en.wikipedia.org/wiki/Wheel_factorization
  def wheel(0,ps), do: 2..size_of_wheel(ps) |> Enum.to_list |> Kernel.--(ps |> spokes |> Kernel.--(ps)) 
  def wheel(n,ps) do
    (n*size_of_wheel(ps)+1)..size_of_wheel(ps)*(n+1) 
    |> Enum.to_list 
    |> Enum.filter(
        &(rem(&1-1,size_of_wheel(ps)) not in (ps |> spokes |> Enum.map(fn x -> x - 1 end))))
  end

  defp spokes(ps) do
      1..size_of_wheel(ps) 
      |> Enum.filter(
        &( ps |> Enum.map(fn x -> rem(&1,x)==0 end) 
        |> Enum.any?(fn x -> x== true end)))
  end

  defp size_of_wheel(ps), do: ps |> Enum.reduce(&(&1*&2))

end
