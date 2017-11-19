defmodule Queens do
  @board List.duplicate("_", 8) |> List.duplicate(8)  

  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(white \\ {0, 3}, black \\ {7, 3})
  def new(pos, pos),do: raise ArgumentError, message: "Queens cannot occupy same space" 
  def new(white, black), do:  %{white: white, black: black}

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(qs), do:  qs |> Enum.reduce(@board, &place_queen/2) |> Enum.map_join("\n", &Enum.join(&1, " ")) 

  defp place_queen({q, {x,y}},bs), do: bs |> List.replace_at(x, bs |> Enum.at(x) |> List.replace_at(y, q |> to_inital_letter))  

  defp to_inital_letter(a), do:  a |> Kernel.to_string |> String.first |> String.upcase

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%{white: {x, _}, black: {x, _}}), do: true
  def can_attack?(%{white: {_, y}, black: {_, y}}), do: true
  def can_attack?(%{white: {x1, y1}, black: {x2, y2}}) when abs(y2 - y1) == abs(x2 - x1), do: true
  def can_attack?(_), do: false
  
end
