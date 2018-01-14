defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.
  """
  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(as, t), do: as |> search(0, tuple_size(as) - 1, t)

  # From https://en.wikipedia.org/wiki/Binary_search_algorithm
  defp search(_as, l, r, _t) when l > r, do: :not_found
  defp search( as, l, r,  t) when elem(as, div(l + r, 2)) < t, do: as |> search(div(l + r, 2) + 1, r, t)
  defp search( as, l, r,  t) when elem(as, div(l + r, 2)) > t, do: as |> search(l, div(l + r, 2) - 1 , t)
  defp search(_as, l, r, _t), do: {:ok, div(l + r,2)}

end
