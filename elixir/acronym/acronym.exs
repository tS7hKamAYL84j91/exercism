defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"

  tried again with some regex faffing... trade concise code for wtf did it do agin :)
  don't match capitals or first letters of words, replace the rest with empty string
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string), do: Regex.replace(~r/(?![A-Z]|\b[a-z])./u,string,"") |> String.upcase
   

end
