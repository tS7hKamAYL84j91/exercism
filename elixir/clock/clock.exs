defmodule Clock do
  @mins_in_day 24 * 60

  defstruct minutes: 0

  defimpl String.Chars, for: Clock do
    def to_string(%Clock{minutes: mm}), do: "#{mm |> fmt_time(&div/2)}:#{mm |> fmt_time(&rem/2)}"

    defp fmt_time(mm, f) when is_function(f),
      do: f.(mm, 60) |> Kernel.to_string() |> String.pad_leading(2, "0")
  end

  @doc """
  Returns a string representation of a clock:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(hh, mm), do: %Clock{minutes: (hh * 60 + mm) |> modulo_mins}

  defp modulo_mins(mm) when rem(mm, @mins_in_day) < 0, do: rem(mm, @mins_in_day) + @mins_in_day
  defp modulo_mins(mm), do: rem(mm, @mins_in_day)

  @doc """
  Adds two clock times:

      iex> Clock.add(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{minutes: mm}, add_mm), do: new(0, mm + add_mm)
end
