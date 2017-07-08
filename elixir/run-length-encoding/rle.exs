defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  Regex
  """
  @spec encode(String.t) :: String.t
  def encode(xs), do:  Regex.replace ~r/([[:alpha:]\s])\1+/, xs, &encoder(&1,&2) 

  @spec decode(String.t) :: String.t
  def decode(xs), do: Regex.replace ~r/(\d+)([[:alpha:]\s])/, xs, &decoder(&1,&2,&3)

  @spec encoder(String.t, String.t) ::  String.t
  defp encoder(xs,x), do: "#{String.length(xs)}#{x}"

  @spec decoder(String.t, String.t, String.t) :: [String.t]
  defp decoder(_,n,x), do: String.duplicate(x, n |> String.to_integer) 

end
