using StatsBase

wordcount(sentence::AbstractString) = (sentence 
    |> lowercase
    |> s -> replace(s, r"(?!\b'\b)[^\w ]" => " ") 
    |> s -> split(s, " ", keepempty=false) 
    |> countmap)
