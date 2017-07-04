defmodule Bob do
  @spec hey(String.t) :: String.t
  def hey(input) do
    cond do
        silence?(input) -> "Fine. Be that way!"
        question?(input) -> "Sure."
        shouting?(input) -> "Whoa, chill out!"
        true -> "Whatever."

    end
  end

  defp shouting?(input), do: (input |> all_upcase?) and !(input |> all_downcase?)

  defp all_downcase?(input), do: String.downcase(input) == input
  defp all_upcase?(input), do: String.upcase(input) == input

  defp question?(input), do: String.last(input) == "?"
  defp silence?(input), do: String.trim(input) == ""

end
