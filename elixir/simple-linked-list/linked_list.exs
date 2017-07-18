defmodule LinkedList do
  @opaque t :: tuple()
  @empty_list {:error, :empty_list}

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new(), do: {}

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(xs, x), do: x <|> xs 

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length({}), do: 0
  def length({_x,xs}), do: 1 + LinkedList.length(xs)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(xs), do: LinkedList.length(xs) == 0

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek({}), do: @empty_list
  def peek({x,_xs}),do: {:ok, x}
  

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail({}), do: @empty_list
  def tail({_x,xs}), do: {:ok, xs}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop({}), do: @empty_list
  def pop({x,xs}), do: {:ok, x, xs}
  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list([]), do: {}
  def from_list([x|xs]), do: x <|> from_list(xs)

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list({}), do: []
  def to_list({x,xs}), do: [x|to_list(xs)]
  
  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(xs), do: reverse(xs,{})
  def reverse({},acc), do: acc
  def reverse({x,xs}, acc), do: reverse xs, x <|> acc 


  @spec any <|> t :: t  
  defp x <|> {y,ys}, do: {x,y <|> ys} 
  defp x <|> {}, do: {x,{}}

  
end
