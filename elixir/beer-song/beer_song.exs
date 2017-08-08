defmodule BeerSong do

  @drink "Take one down and pass it around"
  @drink_last_one "Take it down and pass it around"  
  @buy "Go to the store and buy some more"

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t) :: String.t
  def lyrics(range \\ 99..0), do: range |> Enum.map(&verse/1) |> Enum.join("\n")

  @doc """
  Get a single verse of the beer song
  """

  @spec verse(integer) :: String.t 
  def verse(number) do """
    #{number |> num_of_bottles |> String.capitalize} of beer on the wall, #{number |> num_of_bottles} of beer.
    #{number |> drink_or_buy}, #{number |> num_of_bottles_remaining(number |> drink_or_buy)} of beer on the wall.
    """
  end

  defp num_of_bottles(0), do: "no more bottles"
  defp num_of_bottles(1), do: "1 bottle"
  defp num_of_bottles(number_of_beers), do: "#{number_of_beers} bottles"

  defp drink_or_buy(0), do: @buy
  defp drink_or_buy(1), do: @drink_last_one
  defp drink_or_buy(_), do: @drink
  
  defp num_of_bottles_remaining(_, @buy), do: 99 |> num_of_bottles
  defp num_of_bottles_remaining(number_of_beers, _), do: number_of_beers - 1 |>  num_of_bottles

end
