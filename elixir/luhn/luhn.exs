defmodule Luhn do
  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(number) do
    number
    |> String.codepoints 
    |> Enum.map(&String.to_integer/1) 
    |> Enum.reverse 
    |> Enum.chunk_every(2,2,[0])
    |> Enum.flat_map(fn [a,b] -> [a,b |> luhn_calc] end) 
    |> Enum.sum
  end

  defp luhn_calc(x) when (x * 2) >= 10, do: x * 2 - 9
  defp luhn_calc(x), do: x * 2
  
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def  valid?(number), do: valid? number, number |> valid_represenation
  defp valid?(number, true), do: number |> String.replace(" ","") |> checksum |> Kernel.rem(10)|> Kernel.==(0)
  defp valid?(_, false), do: false

  defp valid_represenation(number), do: number =~ ~r/^[ \d]+$/ 

  @doc """
  Creates a valid number by adding the correct
  checksum digit to the end of the number
  """
  @spec create(String.t()) :: String.t()
  def  create(number), do: create number, number |> valid_represenation
  defp create(number, true), do: number <> (number <> "0" |> checksum |>  Kernel.*(9) |> rem(10) |> to_string)

end
