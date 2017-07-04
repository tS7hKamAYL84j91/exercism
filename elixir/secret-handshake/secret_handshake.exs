defmodule SecretHandshake do
  use Bitwise

  @secret_code [{1, "wink"}, {2, "double blink"}, {4, "close your eyes"}, {8, "jump"}]
  @reverse 16
  
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) when band(@reverse,code) == @reverse, do: commands(bxor(16,code)) |> Enum.reverse
  def commands(code) do
    @secret_code
    |> Enum.filter_map(&((elem(&1,0)  &&& code) == elem(&1,0)), &elem(&1,1)) 
  end
end

