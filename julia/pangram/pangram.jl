ispangram(input::AbstractString) = (input 
    |> lowercase 
    |> s -> replace(s, r"[^a-z]" => "") 
    |> collect 
    |> unique 
    |> length) == 26

