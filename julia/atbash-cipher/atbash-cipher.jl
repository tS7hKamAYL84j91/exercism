atbash(input) = (input 
  |> lowercase 
  |> xs->filter(x->isletter(x) || isnumeric(x), xs) 
  |> xs->map(x->isletter(x) ? Char('z' - (x - 'a')) : x, xs))

encode(input::AbstractString) = input |> atbash |> xs->Base.Iterators.partition(xs, 5) |> xs->join(map(join, xs), " ")
  
decode(input::AbstractString) = input |> atbash