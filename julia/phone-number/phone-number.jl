function clean(phone_number)
  nan = r"^(?:\+?1[-. ]*)?\(?([2-9]{1}[0-9]{2})\)?[-. ]*([2-9]{1}[0-9]{2})[-. ]*([0-9]{4})$"
  phone_number |> strip |> p -> occursin(nan, p) ? match(nan, p) |> m -> m.captures |> join : nothing
end
