defmodule RobotSimulator do
  @direction [:north, :east, :south, :west]
  @modulo @direction |> length

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: { integer, integer }) :: any
  def create(dir \\ :north, pos \\ {0,0}) 
  def create(dir, {x,y} = pos) when dir in @direction and is_integer(x) and is_integer(y), do: {dir, pos}
  def create(dir, _) when dir in @direction, do: {:error, "invalid position"}
  def create(_, _), do: {:error, "invalid direction"}
 
 
  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t ) :: any
  def simulate(robot, instructions), do: instructions |> String.codepoints |> Enum.reduce(robot, &instruction/2)

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot), do: robot |> elem(0) 


  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: { integer, integer }
  def position(robot), do: robot |> elem(1)

  # Suporting functions

  # Reducer to process instructions
  defp instruction( _ , {:error, _} = err), do: err
  defp instruction("R", {dir,pos}), do: {dir |> turn(1), pos}
  defp instruction("L", {dir,pos}), do: {dir |> turn(-1), pos}
  defp instruction("A", {dir,pos}), do: {dir, dir |> advance(pos)}
  defp instruction(_, _), do: {:error, "invalid instruction"}

  # Turn clockwise x or anti clockwise -x
  defp turn(dir, turn), do: @direction |> Enum.at(dir |> dir_to_int |> Kernel.+(turn) |> to_ring)

  # Turn direction to integer
  defp dir_to_int(dir), do: @direction |> Enum.find_index(&(&1 == dir))

  # Key integers on ring 1..(directions |> length)
  defp to_ring(x) when rem(x,@modulo) >= 0, do: x |> rem(@modulo)
  defp to_ring(x) when rem(x,@modulo) <  0, do: x |> rem(@modulo) |> Kernel.+(@modulo)  
  
  # calculate new co-ordinates
  defp advance(:north, {x,y}), do: {x, y+1}
  defp advance(:east,  {x,y}), do: {x+1, y}
  defp advance(:west,  {x,y}), do: {x-1, y}
  defp advance(:south, {x,y}), do: {x, y-1}
  
    

end
