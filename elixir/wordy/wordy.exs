defmodule Wordy do
  @message_types [{~r/\d+/, :ints}, {~r/plus|minus|divided|multiplied/, :ops}, {~r/What|is|by/, :ignore}]

  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t) :: integer
  def answer(question), do: question |> parser

  def parser(xs), do: xs |> String.replace("?", "") |> String.split(" ") |> Enum.reduce([], &parser/2) |> hd

  def parser(x, acc) do 
    @message_types 
    |> Enum.find({nil, :unknown}, fn {r,_m} -> String.match?(x,r) end) 
    |> elem(1) 
    |> parser(x, acc)
  end

  def parser(_, _, :error), do: :error
  def parser(:ints, x, []), do: [x |> String.to_integer]
  def parser(:ints, x, [_a,_b]=xs), do: [xs |> calc(x |> String.to_integer)]
  def parser(:ops, x, xs), do: [x|xs]
  def parser(:ignore, _, xs), do: xs
  def parser(:unknown, _, _), do: :error
  def parser(_, _, _), do: :error

  def calc(["plus", x], y), do: x + y
  def calc(["minus", x], y), do: x - y  
  def calc(["divided", x], y), do: x / y 
  def calc(["multiplied", x], y), do: x * y 

end
