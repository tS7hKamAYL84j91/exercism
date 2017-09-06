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
  # generate builds up a list of possible solutions recursing through the list of available
  # coins in decreasing order
  def generate(_, 0), do: {:ok, []} 
  def generate(cs, t), do: generate(cs |> Enum.sort_by(&(-&1)),t,[])
  defp generate([], _, acc), do: acc |> Enum.filter(&(&1 != :error)) |> smallest_combo
  defp generate([_|cs]=coins, t, acc), do: generate(cs, t, [change(coins, t)| acc]) 

  # formats results and finds shortest combinaition .... really just a safe Enum.min_by :-)
  defp smallest_combo([]), do: {:error, "cannot change"}
  defp smallest_combo(cmbs), do: {:ok, cmbs |> Enum.min_by(&length/1) |> Enum.sort}

  # A greedy approach to creating change
  defp change(cs, t), do: change(cs |> Enum.sort_by(&(-&1)),t,[])
  defp change(_, 0, acc), do: acc
  defp change([], _, acc), do: :error
  defp change([c|cs], t, acc) when c > t, do: cs |> change(t, acc)
  defp change([c|cs]=coins, t, acc) do
    # Stops the greedy approach failing when there are no unit coins @johnsyweb soln
     case coins |> change(t-c, [c | acc]) do
       :error -> cs |> change(t, acc) 
       ok -> ok
     end
  end
end

