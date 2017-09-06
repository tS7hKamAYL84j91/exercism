defmodule Change do
  @cache_name :cache
  @cache_miss :cache_miss

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
  # memoized function needs to set up cache process to hold state of previously calculated coin changes
  def generate(_, 0), do: {:ok, []} 
  def generate(cs, t) do
    with {:ok, _pid} <- cache_start(),  
      [_|_]=results <- cs |> generate_change(t) # change to make sure we have valid change
      do 
        cache_stop()
        {:ok, results}
      else
        e -> cache_stop()
          {:error, "cannot change"} 
    end
  end

  # function generates the coin change for target t, it checks cache first 
  defp generate_change(cs, t) do
    case result = cache_get(cs,t) do
      @cache_miss ->
        # imperative code here .... I like to wrap in a with (feels like haskell's do/bind)
        with result = cs |> change(t)  |> Enum.filter(&(&1 |> Enum.sum  == t)) |> smallest_combo,
        :ok <- cache_set(cs,t, result)
        do
           result
        end
      _ -> result
    end 
  end
 
  # formats results and finds shortest combinaition .... really just a safe Enum.min_by :-)
  defp smallest_combo([]), do: []
  defp smallest_combo(cmbs), do: cmbs |> Enum.min_by(&length/1) |> Enum.sort

  # The following function is based on the solutions for calculating the number of ways to give change
  # Best explanation I've found is https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-11.html#%25_idx_722
  # Basically we recurse back around to generate change because of https://en.wikipedia.org/wiki/Optimal_substructure
  # Generate minmum [1,2,3] for 4 contains [1| generate minumum change for [1,2,3] 3 ]  
  defp change(_, 0), do: []
  defp change([], t), do: []
  defp change([c|cs]=xs, t), do: [[c | generate_change(xs |> Enum.filter(&(&1<=t-c)), t-c)] |  generate_change(cs, t)] |> flatten
  
  # The change function about returns a tree & we need to flatten it to a list of lists
  defp flatten([]), do: []
  defp flatten([h|t]) when is_list(h), do: flatten(h) ++ flatten(t)
  defp flatten(h), do: [h] 

  # Create an agent to memoize results of the generate change function
  defp cache_start, do: Agent.start(fn -> %{} end, name: @cache_name)
  defp cache_get(cs,t), do: Agent.get(@cache_name, &Map.get(&1, {cs,t}, @cache_miss))
  defp cache_set(cs,t, result), do: Agent.update(@cache_name, &Map.put(&1, {cs,t}, result))
  defp cache_stop, do: Agent.stop(@cache_name)
 
end

