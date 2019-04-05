transform(input::Dict{Int64,Array{Char,1}}) = 
    Dict(lowercase(l) => k for (k,ls) in input for l in ls)

#= (input 
|> keys 
|> collect
|> ks -> map(k -> Dict(map(lowercase, input[k]) .=> k), ks) 
|> ks -> reduce(merge, ks)) =#