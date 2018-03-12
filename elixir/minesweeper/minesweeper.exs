defmodule Minesweeper do
  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t()]) :: [String.t()]
  def annotate([]), do: []
  def annotate(bd) do 
    bd 
    |> index_board 
    |> Enum.map(&count_filled_adj_cells(&1, bd |> index_board))
    |> Enum.map(&annotate_cell/1)
    |> rebuild_board
  end
  
  # create index and flatten matrix to single list [a00: {0, 0}, a01: {0, 1}]
  defp index_board(bd) do 
    bd 
    |> Enum.map(&String.codepoints/1) 
    |> Enum.map(&Enum.with_index/1) 
    |> Enum.with_index
    |> Enum.flat_map(&index_row/1)
  end

  defp index_row({rs, row}), do: rs |> Enum.map(fn {r, col} -> {r, {row, col}} end)
  
  # count all cells which are less than 1 away and are filled with *
  defp count_filled_adj_cells({v, p}, bd), do: {v, p, bd |> Enum.filter(&is_filled_adj_cell?(&1, p)) |> length}

  defp is_filled_adj_cell?({v, {w, z}}, {x, y}), do: is_filled_adj_cell?({x, y}, {w, z}) && v == "*"
  defp is_filled_adj_cell?(x, x), do: false
  defp is_filled_adj_cell?({x, y}, {w,z}) when abs(x-w) <= 1 and abs(y-z) <= 1, do: true
  defp is_filled_adj_cell?(_, _), do: false

  # Annotate cells with count of filled adjcent cells
  defp annotate_cell({"*", p, _}), do: {"*", p}
  defp annotate_cell({_, p, l}) when l == 0, do: {" ", p}
  defp annotate_cell({_, p, l}), do: {"#{l}", p}
  
  # recreate board from list of annotated cells
  defp rebuild_board(bs) do
    bs 
    |> Enum.chunk_by(fn {_, {x,_}} -> x end) 
    |> Enum.map(&Enum.map_join(&1, fn {v, _p} -> v end)) 
  end
  
end
