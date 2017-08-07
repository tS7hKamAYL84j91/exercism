defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert(digits, base_a, base_b) when digits == [] or base_a <= 1 or base_b <= 1, do: nil
  def convert(digits, base_a, base_b), do: digits |> to_decimal(base_a) |> to_base(base_b)
    
  defp to_decimal(digits, base), do: digits |> Enum.reverse |> Enum.with_index |> Enum.reduce(0, &to_decimal(&1,&2,base))
  
  defp to_decimal({_digit, _power}, nil, _base), do: nil
  defp to_decimal({digit, power}, acc, base) when digit in 0..(base-1), do: acc + round(digit * :math.pow(base,power))
  defp to_decimal({_digit, _power}, _acc, _base), do: nil

  defp to_base(nil, _base), do: nil 
  defp to_base(0, _base), do: [0]
  defp to_base(num, base), do:  to_base(num, base, [])
  
  defp to_base(num, _base, acc) when num == 0, do: acc
  defp to_base(num, base, acc), do: num |> div(base) |>  to_base(base, [(num |> rem(base)) | acc])

end
