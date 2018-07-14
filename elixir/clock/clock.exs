defmodule Clock do
  defstruct hour: 0, minute: 0

  defimpl String.Chars, for: Clock do
    def to_string(%Clock{hour: hh, minute: mm}),
      do: "#{hh |> pad_leading_zero}:#{mm |> pad_leading_zero}"

    defp pad_leading_zero(i), do: i |> Kernel.to_string() |> String.pad_leading(2, "0")
  end

  defimpl Inspect, for: Clock do
    def inspect(clock, _opts), do: clock |> to_string
  end

  @doc """
  Returns a string representation of a clock:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(hour, minute),
    do: %Clock{hour: clock_hours(hour, minute), minute: clock_minutes(minute)}

  def clock_hours(hh, mm) when rem(mm, 60) < 0, do: clock_hours(hh - 1, div(mm, 60) * 60)
  def clock_hours(hh, mm), do: rem(hh + div(mm, 60), 24) |> clock_hours
  def clock_hours(hh) when hh < 0, do: 24 + hh
  def clock_hours(hh), do: hh

  defp clock_minutes(mm) when rem(mm, 60) < 0, do: 60 + rem(mm, 60)
  defp clock_minutes(mm), do: rem(mm, 60)

  @doc """
  Adds two clock times:

      iex> Clock.add(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute), do: new(hour, minute + add_minute)
end
