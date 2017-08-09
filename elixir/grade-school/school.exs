defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(map, String.t, integer) :: map
  def add(db, name, grade), do: db |> Map.update(grade, [name], fn names -> [name | names] end)

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(map, integer) :: [String.t]
  def grade(db, grade), do: db |> Map.get(grade, [])

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort(map) :: [{integer, [String.t]}]
  def sort(db), do: db |> Enum.map(fn {grade, names} -> {grade, names |> Enum.sort} end) # you can map over maps :)

end
