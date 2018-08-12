defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec is_valid?(integer) :: boolean
  def is_valid?(number) do
    number
    |> Integer.digits()
    |> Enum.reduce(0, fn x, acc -> :math.pow(x, number |> Integer.digits() |> length) + acc end)
    |> Kernel.==(number)
  end
end
