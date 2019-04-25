isisogram(s::AbstractString) = 
  s |> lowercase |> s′->filter(isletter, s′) |> allunique
