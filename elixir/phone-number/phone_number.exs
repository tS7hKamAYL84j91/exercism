defmodule Phone do
  @invalid_resp ["000", "000", "0000"]
  @nanp ~r/^(?:\+?1[-. ]?)?\(?([2-9]{1}[0-9]{2})\)?[-. ]?([2-9]{1}[0-9]{2})[-. ]?([0-9]{4})$/u 
  # From O'Reilly Regular Expression Cookbook: 4.2 North American Phone Numbers

  @doc "Remove formatting from a phone number."
  @spec number(String.t) :: String.t
  def number(raw), do: raw |> vldt_nmbr |> Enum.join
 
  @doc "Extract the area code from a phone number"
  @spec area_code(String.t) :: String.t
  def area_code(raw), do: raw |> vldt_nmbr |> hd

  @doc "Pretty print a phone number"
  @spec pretty(String.t) :: String.t
  def pretty(raw), do: raw |> vldt_nmbr |> frmt_phne_nm

  defp vldt_nmbr(raw) when is_binary(raw), do: Regex.scan(@nanp, raw, capture: :all_but_first) |> List.flatten |> vldt_nmbr
  defp vldt_nmbr([_a, _e, _l] = phone_num), do: phone_num 
  defp vldt_nmbr(_), do: @invalid_resp

  defp frmt_phne_nm([area, exchange, line]), do: "(#{area}) #{exchange}-#{line}"
end
