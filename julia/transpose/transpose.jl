function transpose_strings(input::AbstractArray) 
  maxrow(input) = !isempty(input) ? l = map(length, input) |> maximum : 0
  padrows(input) = map(x -> vcat(collect(x), repeat([:nothing] ,(maxrow(input) - length(x)))), input)
  lastvalue(output) = findlast(x -> x != :nothing, output) 
  clean(output) = (output 
    |> vec
    |> xs -> Iterators.take(xs, lastvalue(xs)) 
    |> xs -> map(x -> x == :nothing ? " " : x, xs) 
    |> join)
  
  input |> padrows |> xs -> map(collect,xs) |> x -> hcat(x...) |> eachrow |> xs -> map(clean,xs)
end