defmodule Acronym do

  @upcase_shift ?a - ?A

  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"

  just a recursion, pattern matching binaries and char lists
  no regex, enum, string libs
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string), do: abbreviate(string, <<>> )

  def abbreviate(<<>>, acc), do: acc
  def abbreviate(<< h :: utf8 , t :: binary >>, acc) when h in ?A..?Z do
    abbreviate(t, acc <> << h :: utf8 >>)
  end 
  def abbreviate(<< h :: utf8, i :: utf8, t :: binary>>, acc) when i in ?a..?z and h in [?\s,?-] do
    abbreviate(t, acc <> << i - @upcase_shift :: utf8 >>)
  end
  def abbreviate(<< _h :: utf8 , t :: binary >>, acc), do: abbreviate(t, acc)


end
