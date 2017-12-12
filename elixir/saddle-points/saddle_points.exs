Code.require_file("matrix.exs", __DIR__ <> "/../matrix/") # load and compile elixir src code into memory.
defmodule SaddlePoints do
  
  alias Matrix, as: M

  @doc """
  Parses a string representation of a matrix to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str),do: str |> M.from_string |> M.rows

  @doc """
  Parses a string representation of a matrix to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str), do: str |> M.from_string |> M.columns

  @doc """
  Calculates all the saddle points from a string representation of a matrix
  It finds points {x,y} that meet the saddle test
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    with  rs <- str |> rows |> saddle_points(:row), # find rows
          cs <- str |> columns |> saddle_points(:col), # find cols
    do: rs -- (rs -- cs) # find the intersection of rows and cols
  end

  #The saddle_points/2 function finds all points in a matrix that meet the row or col test criteria
  defp saddle_points(xs, t) when t |> is_atom and xs |> is_list, do: xs |> Enum.with_index |> Enum.flat_map(&saddle_test(&1, t))

  #The saddle_test/2 function is a helper function that find the points in rows and cols that meet the criteria for 
  defp saddle_test({rs, row}, :row), do: rs |> saddle_test(&Enum.max/1) |> Enum.map(&({row, &1 |> elem(1)}))
  defp saddle_test({cs, col}, :col), do: cs |> saddle_test(&Enum.min/1) |> Enum.map(&({&1 |> elem(1), col}))
  defp saddle_test(xs, f )when f |> is_function and xs |> is_list, do: xs |> Enum.with_index |> Enum.filter(fn x -> x |> elem(0) == f.(xs) end)


end
