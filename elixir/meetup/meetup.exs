defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """
  
  @days_of_week %{monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6, sunday: 7} 
  @schedule %{first: 0, second: 1, third: 2, fourth: 3, last: -1}
  
  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    {year, month, 1..:calendar.last_day_of_the_month(year, month) 
      |> Enum.filter(&(:calendar.day_of_the_week(year, month, &1)) == @days_of_week[weekday])
      |> meetup_day(schedule)}
   end
  
  defp meetup_day(xs, :teenth),  do: xs |> Enum.filter(fn day -> day in 13..19 end) |> meetup_day(:first) 
  defp meetup_day(xs, schedule),   do: xs |> Enum.at(@schedule[schedule])
  
end
