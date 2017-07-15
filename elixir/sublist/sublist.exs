defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a,b) when length(a) > length(b), do: with :sublist <- compare(b,a), do: :superlist
  def compare(a,a), do: :equal # replaced a == b
  def compare([],_b), do: :sublist
  def compare(a, b) do
    cond do
      a in (b |> Enum.chunk(length(a),1)) -> :sublist
      true   -> :unequal
    end    
  end
  


end