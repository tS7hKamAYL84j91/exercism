defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0
  def count([_x|xs]), do: 1 + count(xs)

  @spec reverse(list) :: list
  def reverse(xs), do: reverse(xs,[]) # replaced ++ with an accumulator to speed up reverse
  def reverse([], acc), do: acc
  def reverse([x|xs], acc), do: reverse(xs, [x|acc]) 

  @spec map(list, (any -> any)) :: list
  def map([], _), do: []
  def map([x|xs], f), do: [f.(x)| map(xs, f)]

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _), do: []
  def filter([x|xs], f), do: if f.(x), do: [x | filter(xs, f) ], else: filter(xs, f)

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _), do: acc
  def reduce([x|xs], acc, f), do: reduce(xs, f.(x, acc), f)

  @spec append(list, list) :: list
  def append([], b), do: b
  def append([x|xs], b), do: [x | append(xs, b)]

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([x|xs]), do: append(x, concat(xs))

end