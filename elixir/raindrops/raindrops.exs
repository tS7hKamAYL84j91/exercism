defmodule Raindrops do
  @rainbow %{3 => "Pling", 5 => "Plang", 7 => "Plong"}
  
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number),  do: number |> convert(pl_ng(number))
  def convert(number, []), do: number |> to_string
  def convert(number, xs), do: xs |> Enum.join

  defp pl_ng(number), do: for {k,v} <- @rainbow, rem(number,k) == 0, do: v

end
