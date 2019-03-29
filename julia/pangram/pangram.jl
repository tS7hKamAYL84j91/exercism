ispangram(input::AbstractString) = 
  input |> lowercase |> s -> replace(s, r"[^a-z]" => "") |> collect |> sort |> unique |> length == 26

