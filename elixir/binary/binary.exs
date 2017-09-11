defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(str), do: str |> to_charlist |> Enum.reverse |> Enum.with_index |> Enum.reduce(0, &to_decimal/2) |> round_result
  
  defp to_decimal(_, :error), do: :error
  defp to_decimal({?1, p}, acc), do:  acc + :math.pow(2,p)
  defp to_decimal({?0, _}, acc), do: acc 
  defp to_decimal(_, _), do: :error

  defp round_result(:error), do: 0
  defp round_result(res), do: res |> round 
end
