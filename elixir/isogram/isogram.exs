defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence), do: sentence |> normalise |> Kernel.==(sentence |> normalise |> Enum.uniq)

  defp normalise(sentence), do: sentence |> String.replace(~r/[\s-]/, "") |> String.codepoints 

end
