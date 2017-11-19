defmodule Gigasecond do
  @one_billion_seconds 1.0e9

  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime

  def from(date_time) do
    date_time 
    |> :calendar.datetime_to_gregorian_seconds() 
    |> Kernel.+(@one_billion_seconds)  
    |> round 
    |> :calendar.gregorian_seconds_to_datetime
  end




end
