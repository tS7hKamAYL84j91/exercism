defmodule Say do
  @units ~w/zero one two three four five six seven eight nine/
  @teens ~w/eleven tweleve thirteen fourteen fifteen sixteen seventeen eighteen nineteen/
  @tens ~w/ten twenty thirty forty fifty sixty seventy eighty ninety/
  @chunks ~w/hundred thousand million billion/

  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(n) when n > 999_999_999_999 or n < 0, do: {:error, "number is out of range"}

  def in_english(n),
    do: {:ok, n |> chunk |> Enum.map(&chunk_to_english/1) |> Enum.join(" ") |> String.trim()}

  defp chunk(0), do: [{0, "zero"}]
  defp chunk(n), do: n |> to_chunk |> Enum.zip(@chunks) |> Enum.reverse()

  defp to_chunk(0), do: []
  defp to_chunk(n), do: [rem(n, 1000) | div(n, 1000) |> to_chunk]

  defp chunk_to_english({0, "zero"}), do: to_english(0)
  defp chunk_to_english({0, _}), do: ""
  defp chunk_to_english({n, "hundred"}), do: "#{n |> to_english}"
  defp chunk_to_english({n, unit}), do: "#{n |> to_english} #{unit}"

  defp to_english(n) when n >= 0 and n <= 9, do: @units |> Enum.at(n)
  defp to_english(n) when n >= 11 and n <= 19, do: @teens |> Enum.at(n - 11)
  defp to_english(n) when rem(n, 10) == 0 and n <= 90, do: @tens |> Enum.at(div(n, 10) - 1)

  defp to_english(n) when n < 100,
    do: "#{div(n, 10) |> Kernel.*(10) |> to_english}-#{rem(n, 10) |> to_english}"

  defp to_english(n) when n >= 100 and rem(n, 100) == 0,
    do: "#{div(n, 100) |> to_english} hundred"

  defp to_english(n) when n >= 100,
    do: "#{div(n, 100) |> to_english} hundred #{rem(n, 100) |> to_english}"
end
