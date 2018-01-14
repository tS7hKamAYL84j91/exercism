defmodule Hexadecimal do

  import String, only: [downcase: 1]
  import Enum

  @hex_digits ~c/0123456789abcdef/ |> with_index
  @default 0
  @base 16
  @valid_hex ~r/^[a-fA-F0-9]*$/

  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """
  @spec to_decimal(binary) :: integer
  def to_decimal(xs) when is_binary(xs), do: to_decimal(xs =~ @valid_hex, xs)

  # Default to 0 for invalid and calculate the total for valid hex strings
  defp to_decimal(false, _), do: @default
  defp to_decimal(true, xs), do: xs |> downcase |> to_charlist |> reduce(0, &calc_total/2)
  
  #Reducer that  transforms hex to digit and calculates the total for the entire hex number
  defp calc_total(x, acc), do: (acc * @base + digit_to_decimal(x)) |> round

  #Simple set of functions form  hex_digit -> decimal_value
  for {k,v}  <-  @hex_digits do
    defp digit_to_decimal(unquote(k)), do: unquote(v)
  end
  
end
