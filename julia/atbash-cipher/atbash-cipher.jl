atbash(input) = (input 
  |> lowercase 
  |> xs->filter(x->isletter(x) || isnumeric(x), xs) 
  |> xs->map(x->isletter(x) ? 'z' - x + 'a' : x, xs)) # 'z' + 'a' errors

encode(input::AbstractString) = (input 
  |> atbash 
  |> xs->Base.Iterators.partition(xs, 5) 
  |> xs->join(map(join, xs), " "))

decode(input::AbstractString) = atbash(input)