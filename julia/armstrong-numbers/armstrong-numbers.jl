isarmstrong(n::Int) = n |> digits |> xs->sum(xs.^length(xs)) == n
