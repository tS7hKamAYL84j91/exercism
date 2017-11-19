defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num), do: for n <- 0..num - 1, do: for k <- 0..n, do: rows(n,k)

  def rows(_, 0), do: 1
  def rows(n, k), do: n |> rows(k-1)  |> Kernel.*(n + 1 - k) |> Kernel.div(k)

end
