defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: inteeger) :: list(String.t())
  def slices(_s,size) when size <= 0, do: []
  def slices(s, size), do:  s |> String.codepoints |> Enum.chunk(size, 1) |> Enum.map(&Enum.join/1)

end

