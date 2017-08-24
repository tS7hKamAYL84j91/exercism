defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(x) when x in 1..64, do: {:ok, x |> grains}
  def square(_), do: {:error, "The requested square must be between 1 and 64 (inclusive)" }
  @doc """
  Adds square of each x from 1 to 64.
  """
  @spec total :: pos_integer
  def total, do: {:ok, (65 |> grains) - 1 }

  defp grains(x), do: 1 |> Stream.iterate(&(&1 * 2)) |> Enum.at(x - 1) 
end
