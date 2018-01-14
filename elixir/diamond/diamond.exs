defmodule Diamond do

  @space 32

  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t
  def build_shape(x) when x in ?A..?Z, do: x |> list_rows |> Enum.map_join("\n", &row(&1, x-?A) |> to_string) |> Kernel.<>("\n")

  #create a list of the rows in the diamond e.g. 'ABCBA'
  defp list_rows(?A), do: [?A]
  defp list_rows(x) when x in ?B..?Z, do: (?A..x |> Enum.to_list) ++ (x-1..?A |> Enum.to_list)
 
  # create a single row, based on the letter and the size of the diamond (how many letters)
  # each row is constructed from  left, centre and right element 
  defp row(x,n), do: left(x,n) ++ centre(x) ++ right(x,n)
  
  # create the right hand section of a row based on letter and size of the diamond
  defp right(?A,n), do: List.duplicate(@space,n)
  defp right(x,n), do: List.duplicate(@space,n) |> List.replace_at(x - ?A - 1, x)

  # create the left hand section of the row by reversing the right hand section
  defp left(x,n), do: right(x,n) |> Enum.reverse
  
  # centre section of a row
  defp centre(?A), do: [?A]
  defp centre(_), do: [@space]

end
