defmodule Allergies do
  use Bitwise

  @items ~w/eggs peanuts shellfish strawberries tomatoes chocolate pollen cats/ 

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t]
  def list(flags), do:  @items |> Enum.filter(&allergic_to?(flags,&1))

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to?(flags, item), do: (1  <<< (@items |> Enum.find_index(&(&1 == item))) &&& flags) !=0  

end
