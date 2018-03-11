defmodule Minesweeper do
  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t()]) :: [String.t()]

  def annotate([]), do: []
  def annotate(bd) do
    0..1 
    |> Enum.reduce(bd |> Enum.map(&String.codepoints/1), fn _x, acc -> acc |> annotate_rows |> columns end)
    |> main_diagonal
    |> annotate_rows
    #|> Enum.map(&Enum.map(&1, fn 0 -> " "; x -> x end))
    #|> Enum.map(&Enum.join/1)

  end

  def annotate_rows(bd), do: bd|> Enum.map(fn x -> x |> Enum.reduce([], &annotate_row/2) end)|> Enum.reverse
  
  defp annotate_row("*", [h| acc]) when is_integer(h), do: ["*", h+1|acc]
  defp annotate_row("*", ["*"| _ts]=acc), do: ["*"|acc]
  defp annotate_row("*", []=acc), do: ["*"]
  defp annotate_row(" ", ["*"| _ts]=acc), do: [1|acc]
  defp annotate_row(" ", acc), do: [0|acc]
  defp annotate_row(x, ["*"|_ts]=acc) when is_integer(x), do: [x+1|acc]
  defp annotate_row(x, acc), do: [x|acc]

  #Matrix manipulation

  def columns(mss), do:  0..cols(mss) |> Enum.map(&column(mss,&1))
  
  def column(mss, index), do: mss |> Enum.map(&Enum.at(&1, index))
  
  def main_diagonal(mss), do: (rows(mss)+1) |> main_diagonals((cols(mss)+1)) |> Enum.map(&Enum.map(&1,fn x -> Enum.at(mss, elem(x,0)) |> Enum.at(elem(x,1)) end))

  def main_diagonals(vrows, 1), do: row_diagonals(vrows, 1)
  def main_diagonals(vrows, vcols) when vrows > 0 and vcols > 0, do: row_diagonals(vrows, vcols) ++ col_diagonals(vrows, vcols)

  def row_diagonals(vrows, vcols), do: for r <- vrows-1..0, do: for row <- r..vrows-1, row-r < vcols,  do: {row, row - r}
  
  def col_diagonals(vrows, vcols), do: for c <- 1..vcols-1, do: for col <- c..vcols-1, do: {col-c, col} 



  def cols(mss), do: (mss|> hd |> length) - 1

  def rows(mss), do: (mss |> length) - 1

  def indexed(mss) do 
    mss 
    |> Enum.map(&Enum.with_index/1) 
    |> Enum.with_index
    |> Enum.flat_map(&index_row/1)  

  end

  def index_row({rs,row}), do: rs |> Enum.map(fn {r, col} -> {r, {row, col}} end)
end
