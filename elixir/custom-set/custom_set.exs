# using my solution for Binary Tree to model set
Code.load_file("binary_search_tree.exs", __DIR__ <> "/../binary-search-tree/")

defmodule CustomSet do
  alias BinarySearchTree, as: BST

  @opaque t :: map
  defstruct set: nil

  @custom_set_fns [
    add: {2, :first},
    contains?: {2, :first},
    difference: {2, :both},
    disjoint?: {2, :both},
    empty?: {1},
    equal?: {2, :both},
    intersection: {2, :both},
    subset?: {2, :both},
    union: {2, :both}
  ]

  # Wrap functions with pattern match to extract binary tree from %CustomSet{}
  for set_fn <- @custom_set_fns do
    case set_fn do
      {fn_name, {2, :first}} ->
        def unquote(fn_name)(%CustomSet{set: custom_set}, arg),
          do: custom_set |> unquote(fn_name)(arg)

      {fn_name, {2, :both}} ->
        def unquote(fn_name)(%CustomSet{set: custom_set_1}, %CustomSet{
              set: custom_set_2
            }),
            do: custom_set_1 |> unquote(fn_name)(custom_set_2)

      {fn_name, {1}} ->
        def unquote(fn_name)(%CustomSet{set: custom_set}), do: custom_set |> unquote(fn_name)()
    end
  end

  # Pretty print CustomSet
  defimpl Inspect, for: CustomSet do
    import Inspect.Algebra

    def inspect(%CustomSet{set: custom_set}, opts) do
      concat(["#CustomSet<", to_doc(BST.in_order(custom_set), opts), ">"])
    end
  end

  @spec new(Enum.t()) :: t
  def new(xs), do: xs |> Enum.reduce(%CustomSet{}, fn x, tree -> add(tree, x) end)

  @spec empty?(t) :: boolean
  def empty?(custom_set), do: custom_set == nil

  @spec contains?(t, any) :: boolean
  def contains?(tree, _data) when tree == nil, do: false
  def contains?(%{data: node_data}, data) when data == node_data, do: true

  def contains?(%{data: node_data} = tree, data) when data < node_data,
    do: contains?(tree.left, data)

  def contains?(%{data: node_data} = tree, data) when data > node_data,
    do: contains?(tree.right, data)

  @spec subset?(t, t) :: boolean
  def subset?(custom_set_1, custom_set_2) do
    custom_set_1
    |> set_operation(
      fn elmnt, subset ->
        contains?(custom_set_2, elmnt) and subset
      end,
      true
    )
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?(custom_set_1, custom_set_2) do
    custom_set_1
    |> set_operation(
      fn elmnt, subset ->
        not contains?(custom_set_2, elmnt) and subset
      end,
      true
    )
  end

  @spec equal?(t, t) :: boolean
  def equal?(custom_set_1, custom_set_2),
    do: subset?(custom_set_1, custom_set_2) and subset?(custom_set_2, custom_set_1)

  @spec add(t, any) :: t
  def add(custom_set, elmnt) do
    case custom_set |> contains?(elmnt) do
      true -> custom_set |> to_custom_set
      false -> custom_set |> BST.insert(elmnt) |> to_custom_set
    end
  end

  @spec intersection(t, t) :: t
  def intersection(custom_set_1, custom_set_2) do
    custom_set_1
    |> set_operation(&case_reducer(&1, &2, fn elmnt -> contains?(custom_set_2, elmnt) end))
    |> to_custom_set
  end

  @spec difference(t, t) :: t
  def difference(custom_set_1, custom_set_2) do
    custom_set_1
    |> set_operation(&case_reducer(&1, &2, fn elmnt -> not contains?(custom_set_2, elmnt) end))
    |> to_custom_set
  end

  @spec union(t, t) :: t
  def union(custom_set_1, custom_set_2),
    do: custom_set_1 |> set_operation(&add(&2, &1), custom_set_2) |> to_custom_set

  defp set_operation(custom_set_1, reducer, initial_case \\ nil) do
    custom_set_1 |> BST.in_order() |> Enum.reduce(initial_case, &reducer.(&1, &2))
  end

  defp case_reducer(elmnt, subset, test_fn) do
    case test_fn.(elmnt) do
      true -> add(subset, elmnt)
      false -> subset
    end
  end

  def to_custom_set(%CustomSet{set: _bst} = custom_set), do: custom_set
  def to_custom_set(bst), do: %CustomSet{set: bst}
end
