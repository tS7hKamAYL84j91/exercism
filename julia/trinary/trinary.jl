trinary_to_decimal(str::AbstractString) = 
  occursin(r"[^0-2]", str) ? 0 : 
    (str 
    |> xs->zip(xs, (length(str) - 1):-1:0, )
    |> xs->map(x->parse(Int, x[1]) * 3^x[2], xs)
    |> sum)
