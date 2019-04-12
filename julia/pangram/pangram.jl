ispangram(input::AbstractString) = (input 
    |> lowercase 
    |> s->replace(s, r"[^a-z]" => "") 
    |> collect 
    |> unique 
    |> sort) == 'a':'z'

