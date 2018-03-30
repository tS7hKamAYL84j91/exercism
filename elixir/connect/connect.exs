defmodule Connect do
  @doc """
  Calculates the winner (if any) of a board
  using "O" as the white player
  and "X" as the black player
  """
  @spec result_for([String.t()]) :: :none | :black | :white
  def result_for(bd), do: bd |> find_connected_pieces |> determine_winner(bd)

  # Find paths of connected pieces; using breadth first search
  defp find_connected_pieces(bd) do 
    bd
    |> index_board 
    |> Enum.reduce([], fn {piece,idx}, acc -> [{piece, bfs(bd |> index_board |> to_graph, idx)} | acc] end )
  end

  # create index and flatten matrix to single list [a00: {0, 0}, a01: {0, 1}]
  defp index_board(bd) do 
    bd 
    |> Enum.map(&String.codepoints/1) 
    |> Enum.map(&Enum.with_index/1) 
    |> Enum.with_index
    |> Enum.flat_map(&index_row/1)
    |> Enum.filter(&elem(&1,0) != ".")
  end

  defp index_row({rs, row_num}), do: rs |> Enum.map(fn {cell_value, col_num} -> {cell_value, {row_num, col_num}} end)

  #Create graph described as adjency list for the board {{x,y}, [{w,z}, {a,b}]}
  defp to_graph(idx_bd) do
    idx_bd
    |> Enum.map(&adj_cells(&1, idx_bd))
    |> Enum.map(fn {_, idx, vs} -> {idx, (fn vs -> vs |> Enum.map(fn {_, idx} -> idx end) end).(vs)} end)
  end

  # create graph adjency list based on adjecent cells with the same value. 
  defp adj_cells({piece, idx}, bd), do: {piece, idx, bd |> Enum.filter(&adj_cell?(&1, idx) && &1 |> elem(0) == piece)}

  defp adj_cell?({_piece, {w, z}}, {x, y}), do: adj_cell?({x, y}, {w, z})
  defp adj_cell?(x, x), do: false
  defp adj_cell?({x, y}, {x,z}) when (z == y-1 or z == y+1), do: true
  defp adj_cell?({x, y}, {w,z}) when w == x-1 and (z == y or z == y+1), do: true
  defp adj_cell?({x, y}, {w,z}) when w == x+1 and (z == y or z == y-1), do: true
  defp adj_cell?(_, _), do: false

  # determine which player won by checking to see if the path is top to bottom or side to side.
  defp determine_winner(set_of_paths_on_board, bd) do 
    set_of_paths_on_board
    |> Enum.map( fn {piece,ps} -> {piece, ps |> winning_path(0, bd |> board_dimensions(piece) ,piece)} end)
    |> Enum.find(&elem(&1,1))
    |> result
  end
 
  # X plays left to right, O plays up and down
  defp board_dimensions(bd, "O"), do: bd |> length |> Kernel.-(1)
  defp board_dimensions(bd, "X"), do: bd |> hd |> String.length |> Kernel.-(1)
  
  #breadth first search for paths in a graph https://en.wikipedia.org/wiki/Breadth-first_search
  defp bfs(graph, root), do: bfs([root], [], graph)
  
  defp bfs([]=_queue, visited, _), do: visited |> Enum.sort
  defp bfs([q|queue], visited, graph), do: bfs update_queue(q, graph, queue, visited), [q| visited], graph

  defp update_queue(current_idx, graph, queue, visited) do
    graph
    |> Enum.find(fn {idx,_} -> idx == current_idx end) 
    |> elem(1) # get list of adject cells
    |> Kernel.--(visited) 
    |> Kernel.++(queue)  
  end

  defp winning_path(ps, min, max, piece), do: ps|> Enum.map(&x_or_y(&1, piece)) |> Enum.min_max |> Kernel.==({min, max})

  defp x_or_y({x,_y}, "O"), do: x
  defp x_or_y({_x,y}, "X"), do: y

  defp result({"X", _}), do: :black
  defp result({"O", _}), do: :white
  defp result(_), do: :none
  
end
