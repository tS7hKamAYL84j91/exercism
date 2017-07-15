defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.

  Huge test input was asking for some changes to try and make faster
  Navie approach just use streams and make the comparison async in a new process
  
  Replaced member? with any? test
  $ elixir sublist/sublist_test.exs  | grep huge
    * test huge sublist not in huge list (1050.5ms) <- 1258 (1st iteration)
    * test superlist early in huge list (165.2ms) <- 752
    * test sublist early in huge list (120.6ms) <- 764

  """
  def compare(a,a), do: :equal # replaced a === b
  def compare(a,b) when length(a) > length(b), do: with :sublist <- compare(b,a), do: :superlist
  def compare(a,b) when length(a) == length(b), do: :unequal
  def compare([],_b), do: :sublist
  def compare(a, b), do: b |> Stream.chunk(length(a),1) |> Enum.member?(a) |> comparator
  
  defp comparator(false), do: :unequal
  defp comparator(true), do: :sublist

end

