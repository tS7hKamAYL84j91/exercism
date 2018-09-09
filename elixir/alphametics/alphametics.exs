defmodule Alphametics do
  @type puzzle :: binary
  @type solution :: %{required(?A..?Z) => 0..9}

  @doc """
  Takes an alphametics puzzle and returns a solution where every letter
  replaced by its number will make a valid equation. Returns `nil` when
  there is no valid solution to the given puzzle.

  ## Examples

      iex> solve("I + BB == ILL")
      %{?I => 1, ?B => 9, ?L => 0}

      iex> solve("A == B")
      nil
  """
  @spec solve(puzzle) :: solution | nil
  def solve(puzzle), do: puzzle |> possible_solns |> correct_solns(puzzle) |> format_results

  def possible_solns(puzzle) do
    puzzle
    |> puzzle_letters
    |> length
    |> combination(Enum.to_list(0..9))
    |> Stream.flat_map(&LazyPermutations.permutations/1)
    |> Stream.map(&Stream.zip(puzzle_letters(puzzle), &1))
  end

  def puzzle_letters(puzzle) do
    puzzle
    |> parse
    |> List.flatten()
    |> Enum.flat_map(&String.codepoints/1)
    |> Enum.sort()
    |> Enum.dedup()
  end

  def parse(puzzle) do
    puzzle |> String.replace(" ", "") |> String.split("==") |> Enum.map(&String.split(&1, "+"))
  end

  def correct_solns(solns, puzzle) do
    solns
    |> Stream.filter(&legal_soln?(&1, puzzle))
    |> Stream.filter(&correct_soln?(&1, puzzle))
    |> Enum.take(1)
  end

  def legal_soln?(soln, puzzle),
    do: soln |> Enum.filter(&(not valid_score?(&1, puzzle))) |> length == 0

  def valid_score?({letter, 0}, puzzle), do: not (letter in non_zero_letters(puzzle))
  def valid_score?(_letter_score, _puzzle), do: true

  def non_zero_letters(puzzle) do
    puzzle
    |> parse()
    |> List.flatten()
    |> Enum.map(&String.first/1)
    |> Enum.sort()
    |> Enum.dedup()
  end

  def correct_soln?(soln, puzzle) do
    puzzle
    |> parse
    |> Enum.map(&total_score(&1, soln))
    |> Enum.dedup()
    |> length
    |> Kernel.==(1)
  end

  def total_score(words, soln), do: words |> Enum.map(&word_score(&1, soln)) |> Enum.sum()

  def word_score(word, soln) do
    word
    |> String.codepoints()
    |> Enum.map(&letter_score(&1, soln))
    |> Enum.join("")
    |> String.to_integer()
  end

  def letter_score(letter, soln), do: soln |> Enum.find(&(&1 |> elem(0) == letter)) |> elem(1)

  def combination(0, _), do: [[]]
  def combination(_, []), do: []

  def combination(n, [x | xs]),
    do: for(y <- combination(n - 1, xs), do: [x | y]) ++ combination(n, xs)

  def format_results([]), do: nil

  def format_results([first_result | _]) do
    first_result
    |> Enum.map(fn {l, v} -> {l |> String.to_charlist() |> hd, v} end)
    |> Enum.into(%{})
  end
end

defmodule LazyPermutations do
  @moduledoc """
  adapted from https://gist.github.com/tallakt/61ef5873721a28c4f7e1
  """

  def permutations(list), do: list |> Enum.sort() |> Stream.unfold(&unfold_permutation/1)

  defp unfold_permutation([]), do: nil
  defp unfold_permutation(p), do: {p, next_permutation(p)}

  defp is_last(permutation), do: permutation == permutation |> Enum.sort() |> Enum.reverse()

  defp next_permutation(permutation), do: next_permutation(permutation, is_last(permutation))
  defp next_permutation(_, true), do: []
  defp next_permutation(permutation, false), do: permutation |> split |> heal

  def split(permutation) do
    permutation
    |> Enum.reverse()
    |> Enum.reduce({0, false, [], []}, &splitter/2)
    |> (fn {_, _, first, last} -> {first, last} end).()
  end

  def splitter(x, {prev, false, first, last}), do: {x, x < prev, first, [x | last]}
  def splitter(x, {_prev, true, first, last}), do: {x, true, [x | first], last}

  def heal({first, last}), do: first ++ [next(last)] ++ rest(last, next(last))

  def next([x | xs]), do: xs |> Enum.filter(&(&1 > x)) |> Enum.min()

  def rest(last, next), do: (last -- [next]) |> Enum.sort()
end
