defmodule Allergies do
  use Bitwise

  @items ~w/eggs peanuts shellfish strawberries tomatoes chocolate pollen cats/ 
    |> Enum.with_index 
    |> Enum.map(fn {p,x} -> {p, :math.pow(2,x) |> trunc} end )       

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t]
  def list(flags), do:  @items |> Enum.filter(fn {_, bit} -> (flags  &&& bit) != 0 end) |> Enum.map(&(&1 |> elem(0)))

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to?(flags, item), do: item in list(flags) 

end
