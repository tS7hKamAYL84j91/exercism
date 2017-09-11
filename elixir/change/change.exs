defmodule Change do
  @doc """
    Determine the least number of cs to be given to the user such
    that the sum of the cs' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of cs. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """
  @spec generate(list, integer) :: {:ok, list} | {:error, String.t}
  # generate dynamic programming approach; we can build up solutions based on observation
  # the soln for t [i1 ..in] contains a best solution for t - i1 [i1...in] and soln for 0 is []
  # so you can build to the target by calculating the best solutions for all the other numbers
  # nased on @netonion's solution
  def generate(_, 0), do: {:ok, []} 
  def generate(cs, t), do:  1..t |> Enum.reduce(%{0 => []}, &change(&1, &2, cs)) |> Map.get(t) |> format_result

  defp change(t, acc, cs) do 
    cs 
    |> Enum.filter(&acc[t - &1]) # Filter the coins for those which can be added to a previous solution to give the target 
    |> Enum.map(&[&1 | acc[t - &1]]) # Create set of new possibilities for providing change
    |> Enum.min_by(&length/1, fn -> nil end) # pick the smallest
    |> (&Map.put(acc,t, &1)).() # add the smallest combinaiton to the accumulator
  end

  # formats results and finds shortest combinaition
  defp format_result(nil), do: {:error, "cannot change"}
  defp format_result(cmb), do: {:ok, cmb}

end

