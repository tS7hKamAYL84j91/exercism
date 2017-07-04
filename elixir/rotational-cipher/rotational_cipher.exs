defmodule RotationalCipher do
  
  @lcase ?a..?z
  @ucase ?A..?Z
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do  
    text 
    |> to_charlist 
    |> Enum.map(&Map.get(cipher_map(shift),&1,&1))
    |> to_string
  end

  def cipher_map(shift), do: Map.merge(cipher_map(@lcase,shift),cipher_map(@ucase,shift))
  def cipher_map(plain,shift) do 
    plain
    |>Enum.zip(
      plain  
      |> Enum.split(rem(shift,Enum.count(plain))) 
      |> (fn {h,t} -> t ++ h  end).())
    |> Enum.into(%{})
  end
end

