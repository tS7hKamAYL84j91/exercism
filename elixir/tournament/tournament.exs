defmodule Either do
  defmacro either(expression) do
    quote do
      try do
        {:ok,unquote(expression)}
      rescue
        e -> {:error,e}
      end
    end
  end
end

defmodule Tournament do
  require Either

  @lose "loss"
  @win "win"
  @draw "draw"

  @report_heading "Team                           | MP |  W |  D |  L |  P"
  @report_fields [:mp, :w, :d, :l, :points]

  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total result_table
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 result_table, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total result_table for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input), do: "#{@report_heading}\n#{input |> parse |> format_results}"

  defp parse(input), do: input |> Enum.reduce(%{}, &parse_result/2) 
  
  defp format_results(results) do
    results
    |> Enum.to_list  # need enumerable that has an order
    |> Enum.sort # sort by team name
    |> Enum.sort_by(fn {_, result_table} -> result_table.points end, &>=/2) # sort by points descending
    |> Enum.map(&format_result/1) # pretty print result line
    |> Enum.join("\n") # merge
  end
  
  defp parse_result(line, results) do 
    with  {:ok, [t1, t2, result]} <- line |> String.split(";") |> parse_line |> Either.either, # use macro to trap errors, let functions just fail
          [t1_result_table , t2_result_table] <- game_results(result) |> Enum.map(&result_table/1)
    do
      results |> Map.merge(%{t1 => t1_result_table, t2 => t2_result_table}, &merge_result_table/3)
    else
      _ -> results
    end
  end

  defp parse_line([_, _, result]=xs) when result in [@win, @lose, @draw], do: xs

  defp game_results(@win),  do: [:win, :loss]
  defp game_results(@lose), do: [:loss, :win]
  defp game_results(@draw), do: [:draw, :draw]

  defp result_table(:win),  do: %{:mp => 1, :w => 1, :d => 0, :l => 0, :points => 3}
  defp result_table(:draw), do: %{:mp => 1, :w => 0, :d => 1, :l => 0, :points => 1}
  defp result_table(:loss), do: %{:mp => 1, :w => 0, :d => 0, :l => 1, :points => 0}

  defp merge_result_table(_, result_table1, result_table2) do 
    result_table1 
    |> Map.merge(result_table2, fn _k , v1, v2 -> v1 + v2 end)
  end

  defp format_result({team, result_table})  do
    "#{team |> String.pad_trailing(31, " ")}|  #{@report_fields |> Enum.map(&result_table[&1]) |> Enum.join(" |  ")}"
  end
  end

