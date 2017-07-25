defmodule Matrix do
  defstruct matrix: nil

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    input 
    |> String.split("\n") # split rows
    |> Enum.map(&String.split(&1, "\s"))  # split cols
    |> Enum.map(&matrix_to_integers/1) # coerce
    |> to_matrix_struct # map to struct
  end

  defp to_matrix_struct(input), do: struct(Matrix, matrix: input)
  defp matrix_to_integers(row), do: row |> Enum.map(&String.to_integer/1)
  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(matrix), do: matrix.matrix |> Enum.map(&Enum.join(&1, "\s")) |> Enum.join("\n")

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(matrix), do: matrix.matrix

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(matrix, index), do: matrix.matrix |> Enum.at(index) 

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(matrix), do:  0..cols(matrix) |> Enum.map(&column(matrix,&1))

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(matrix, index), do: matrix.matrix |> Enum.map(&Enum.at(&1, index))

  defp cols(matrix), do: (matrix.matrix |> hd |> length) - 1
 

end

