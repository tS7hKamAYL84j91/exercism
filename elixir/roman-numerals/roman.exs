defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @numerals  %{1 => "I", 4 => "IV", 5 => "V", 9 => "IX", 10 => "X",
    40 => "XL", 50 => "L", 90 => "XC", 100 => "C", 400 => "CD",
    500 => "D", 900 => "CM", 1000 => "M"}

  @spec numerals(pos_integer) :: String.t
  def numerals(x), do: x |> to_numerals
  
  defp to_numerals(x) do
    @numerals
    |> Map.keys # get facrors associated with numerals
    |> Enum.sort(&(&1 >= &2)) # sort desc
    |> Enum.reduce({x, ""},&reduce_to_numerals/2) # transform each factor to a numeral
    |> elem(1) # drop residual (0) from the accumulator 
  end

  defp reduce_to_numerals(x, {rmdr, xs}) do {
    rmdr |> rem(x), # residual after dividing current residual by x ... reducing to 0  
    xs <> String.duplicate(@numerals[x], div(rmdr,x))} # create Roman Numerals string
  end


end
