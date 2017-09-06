defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers) do
    texts
    |> Task.async_stream(fn xs -> xs |> normalise |> count end, max_concurrency: workers)
    |> Enum.reduce(%{}, fn {:ok, x}, acc -> Map.merge(x,acc, fn _k, x, y -> x + y end  ) end)
  end

  def normalise(str), do: str |> String.replace(~r/[[:digit:][:space:]\p{P}\p{S}]/, "") |> String.downcase  |> String.codepoints

  def count(xs), do: xs |> Enum.reduce(%{}, fn x, acc -> acc |> Map.update(x,1, &(&1+1)) end)

end
