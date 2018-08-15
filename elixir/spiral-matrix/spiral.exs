defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral_path order.
  """
  @spec matrix(dimension :: integer) :: list(list(integer))
  def matrix(0), do: []

  def matrix(dimension),
    do: dimension |> to_sqr_list |> to_sqr_matrix(dimension) |> to_spiral_matrix(dimension)

  defp to_sqr_list(x), do: 1..(x * x)

  defp to_sqr_matrix(xs, x), do: Enum.chunk_every(xs, x)

  defp to_spiral_matrix(xss, dimension) do
    xss
    |> spiral_path
    |> Enum.zip(to_sqr_list(dimension))
    |> Enum.sort()
    |> Enum.map(&elem(&1, 1))
    |> to_sqr_matrix(dimension)
  end

  # follows the explanation here  https://coderbyte.com/algorithm/print-matrix-spiral_path-order
  defp spiral_path(xss), do: spiral_path(xss, [])
  defp spiral_path([], acc), do: acc |> Enum.reverse() |> List.flatten()
  defp spiral_path([xs | []], acc), do: spiral_path([], [xs | acc])
  defp spiral_path([xs | xss], acc), do: spiral_path(xss |> transpose, [xs | acc])

  def transpose(xs), do: xs |> Enum.zip() |> Enum.map(&Tuple.to_list(&1)) |> Enum.reverse()
end
