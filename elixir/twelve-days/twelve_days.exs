defmodule TwelveDays do
  
  @gifts_by_day %{
    1 => %{day: "first", gift: "a Partridge in a Pear Tree"},
    2 => %{day: "second", gift: "two Turtle Doves"},
    3 => %{day: "third", gift: "three French Hens"},
    4 => %{day: "fourth", gift: "four Calling Birds"},
    5 => %{day: "fifth", gift: "five Gold Rings"},
    6 => %{day: "sixth", gift: "six Geese-a-Laying"},
    7 => %{day: "seventh", gift: "seven Swans-a-Swimming"},
    8 => %{day: "eighth", gift: "eight Maids-a-Milking"},
    9 => %{day: "ninth", gift: "nine Ladies Dancing"},
    10 => %{day: "tenth",gift: "ten Lords-a-Leaping"},
    11 => %{day: "eleventh", gift: "eleven Pipers Piping"},
    12 => %{day: "twelfth", gift: "twelve Drummers Drumming"}
  }

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    "On the #{day_to_word(number)} day of Christmas my true love gave to me, #{gifts(number)}."
  end

  defp day_to_word(day), do: @gifts_by_day[day].day
  defp day_to_gift(day), do: @gifts_by_day[day].gift
  
  defp gifts(day) when day > 1 do
    day..2 
    |> Enum.map(&day_to_gift/1)
    |> Enum.join(", ")
    |> Kernel.<>(", and #{gifts(1)}")
  end
  
  defp gifts(day) when day == 1, do: day_to_gift(day)




  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing():: String.t()
  def sing, do: verses(1,12) 
end

