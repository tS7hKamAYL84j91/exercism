defmodule Garden do
  @students  ~w/alice bob charlie david eve fred ginny harriet ileana joseph kincaid larry/a
  @plants    %{"C" => :clover, "G" => :grass, "R" => :radishes, "V" => :violets}
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @students) do
    student_names 
    |> Map.new(fn x -> {x, {}} end) # All students with no plants
    |> Map.merge( # overlay students matched to plants
      student_names
      |> Enum.sort_by(&Atom.to_string/1)
      |> Enum.zip(info_string |> parse_info |> Enum.map(&format_info/1)) # match plants to students
      |> Enum.into(%{}))
  end

  defp parse_info(info_string), do: info_string |> String.split("\n") |> Enum.map(&String.codepoints/1) |> group_plants 
  
  defp group_plants([[p1, p2| []], [p3, p4| []]]), do: [[p1, p2, p3, p4] ]
  defp group_plants([[p1, p2| r1], [p3, p4| r2]]), do: [[p1, p2, p3, p4] | [r1, r2] |> group_plants]

  defp format_info(plant_codes), do: plant_codes |> Enum.map(&(@plants[&1])) |> List.to_tuple
end
