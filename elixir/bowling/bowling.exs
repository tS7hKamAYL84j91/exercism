defmodule Bowling do
  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game; its just an empty list of ready to store frames
  """
  @spec start() :: []
  def start, do: []

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message. Matches roll to a frame {:frame_type , {r1,r2,r3}, frame_number}
  """
  @spec roll(any, integer) :: [{atom, tuple, integer}] | String.t()
  def roll(_, r) when r < 0, do: {:error, "Negative roll is invalid"}
  def roll(_, r) when r > 10, do: {:error, "Pin count exceeds pins on the lane"}
  def roll([{:in_progress, {r1}, _}| _],r) when r+r1>10, do:  {:error, "Pin count exceeds pins on the lane"}
  def roll([{_, {_,_,_} , f}|_fs], _) when f == 10, do: {:error, "Cannot roll after game is over"}
  def roll([{_, {r1,r2} , f}|_fs], _) when f == 10 and (r1 != 10 and r1+r2 != 10 and r2 != 10), do: {:error, "Cannot roll after game is over"}
  def roll([{_, {r1,r2}, f}| _fs], r) when f == 10 and r1 == 10  and r2 != 10 and r2+r > 10, do: {:error, "Pin count exceeds pins on the lane"}
  def roll([], 10), do: [{:strike, {10}, 1}]
  def roll([], r), do: [{:in_progress, {r}, 1}]
  def roll([{_, {r1}, f}| fs],r) when f == 10, do: [{:final, {r1,r}, f}|fs]
  def roll([{_, {r1,r2}, f}| fs],r) when f == 10, do: [{:final, {r1,r2,r}, f}|fs]
  def roll([{:in_progress, {r1}, f}| fs],r) when r+r1 == 10, do: [{:spare, {r1,r}, f}|fs]
  def roll([{:in_progress, {r1}, f}| fs],r), do: [{:open, {r1,r}, f}|fs]
  def roll([{_, _, f}=fr| fs],10), do: [{:strike, {10}, f+1}, fr|fs]
  def roll([{_, _, f}=fr| fs],r), do:  [{:in_progress, {r}, f+1}, fr|fs]

  @doc """
    Returns the score of a given game of bowling if the game is complete. If the game isn't complete, it returns a helpful message.
  """
  @spec score(any) :: integer | String.t()
  def score([]), do: {:error, "Score cannot be taken until the end of the game"}
  def score([{_, _, f}| _]) when f < 10, do: {:error, "Score cannot be taken until the end of the game"}
  def score([{_, {_}, f}| _]) when f == 10, do: {:error, "Score cannot be taken until the end of the game"}
  def score([{_, {r1, r2}, f}| _]) when f == 10 and (r1+r2 == 10 or r1==10), do: {:error, "Score cannot be taken until the end of the game"}
  def score(game), do: game |> Enum.reverse|> Enum.reduce(%{score: 0, bonus: []}, &score/2) |> Map.get(:score)

  defp score({:strike,       {_}=fs, _}, %{score: score, bonus: bs}), do: %{score: score + frame_score(fs, bs), bonus: [2| bs |> use_bonus(1)]}
  defp score({:spare,      {_,_}=fs, _}, %{score: score, bonus: bs}), do: %{score: score + frame_score(fs, bs), bonus: [1| bs |> use_bonus(2)]}
  defp score({:open,       {_,_}=fs, _}, %{score: score, bonus: bs}), do: %{score: score + frame_score(fs, bs), bonus: bs |> use_bonus(2)}
  defp score({:final,      {_,_}=fs, _}, %{score: score, bonus: bs}), do: %{score: score + frame_score(fs, bs), bonus: []}
  defp score({:final,    {_,_,_}=fs, _}, %{score: score, bonus: bs}), do: %{score: score + frame_score(fs, bs), bonus: []}
  defp score({:in_progress,  {_}=fs, _}, %{score: score, bonus: bs}), do: %{score: score + frame_score(fs, bs), bonus: bs |> use_bonus(1)}

  defp frame_score(rolls, bs), do: rolls |> Tuple.to_list |> Enum.with_index |> Enum.map(&add_bonus_points(&1, bs)) |> Enum.sum
 
  defp add_bonus_points({score, index}, bs), do: score * (bs |> use_bonus(index) |> length |> Kernel.+(1))
  
  defp use_bonus(bs, number_of_rolls), do: bs |> Enum.map(&Kernel.-(&1, number_of_rolls) |> Kernel.max(0)) |> Enum.filter(&(&1>=1))

end
