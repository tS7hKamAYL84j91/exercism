defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten([]), do: []
  def flatten([nil | xss]), do: xss |> flatten
  def flatten([xs | xss]) when is_list(xs), do: xs |> flatten |> append(xss |> flatten)
  def flatten([x | xss]), do: [ x | xss |> flatten]

  defp append([], b), do: b # from ListOps exercise
  defp append([x|xs], b), do: [x | xs |> append(b)] # from ListOps exercise
end
