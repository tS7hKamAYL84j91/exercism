defmodule BinTree do
  import Inspect.Algebra

  @moduledoc """
  A node in a binary tree.

  `value` is the value of a node.
  `left` is the left subtree (nil if no subtree).
  `right` is the right subtree (nil if no subtree).
  """
  @type t :: %BinTree{value: any, left: BinTree.t() | nil, right: BinTree.t() | nil}
  defstruct value: nil, left: nil, right: nil

  # A custom inspect instance purely for the tests, this makes error messages
  # much more readable.
  #
  # BT[value: 3, left: BT[value: 5, right: BT[value: 6]]] becomes (3:(5::(6::)):)
  def inspect(%BinTree{value: v, left: l, right: r}, opts) do
    concat([
      "(",
      to_doc(v, opts),
      ":",
      if(l, do: to_doc(l, opts), else: ""),
      ":",
      if(r, do: to_doc(r, opts), else: ""),
      ")"
    ])
  end
end

defmodule Branch do
  #From https://wiki.haskell.org/Zipper
  @type t :: %Branch{choice: nil | :left | :right, value: any, node: BinTree.t()}
  defstruct choice: nil, value: nil, node: nil
end

defmodule Zipper do
  #From https://wiki.haskell.org/Zipper
  @type t :: %Zipper{thread: [Branch.t()], node: BinTree.t()}
  defstruct thread: [], node: %BinTree{}

  alias Zipper, as: Z
  alias Branch, as: BR
  alias BinTree, as: BT

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BT.t()) :: Z.t()
  def from_tree(bt), do: %Z{thread: [], node: bt}
 
  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Z.t()) :: BT.t()
  def to_tree(%Z{thread: [], node: bt}) , do: bt
  def to_tree(bt) , do: bt |> up |> to_tree
  
  @doc """
  Get the value of the focus node.
  """
  @spec value(Z.t()) :: any
  def value(%Z{node: %BT{value: v}}), do: v 

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Z.t()) :: Z.t() | nil
  def left(%Z{node: %BT{left: nil}}), do: nil
  def left(%Z{thread: ts, node: %BT{value: v, left: l, right: r}})  do
    %Z{thread: [%BR{choice: :left, value: v, node: r}|ts], node: l}
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Z.t()) :: Z.t() | nil
  def right(%Z{node: %BT{right: nil}}), do: nil
  def right(%Z{thread: ts, node: %BT{value: v, left: l, right: r}}) do 
    %Z{thread: [%BR{choice: :right, value: v, node: l}|ts], node: r}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Z.t()) :: Z.t()
  def up(%Z{thread: []}), do: nil
  def up(%Z{thread: [%BR{choice: :right, value: v, node: l}|ts], node: n}) do 
    %Z{thread: ts, node: %BT{value: v, left: l, right: n}}
  end
  def up(%Z{thread: [%BR{choice: :left, value: v, node: r}|ts], node: n}) do 
    %Z{thread: ts, node: %BT{value: v, left: n, right: r}}
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Z.t(), any) :: Z.t()
  def set_value(%Z{node: n}=z, v), do: %Z{z| node: %BT{n | value: v}}

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Z.t(), BT.t()) :: Z.t()
  def set_left(%Z{node: n}=z, l), do: %Z{z| node: %BT{n | left: l}}

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Z.t(), BT.t()) :: Z.t()
  def set_right(%Z{node: n}=z, r), do: %Z{z| node: %BT{n | right: r}}
end
