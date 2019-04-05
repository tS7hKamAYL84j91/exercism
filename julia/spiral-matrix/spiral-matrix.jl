function spiral_matrix_printer(m)
  # see https://www.coderbyte.com/algorithm/print-matrix-spiral-order
    top_right(m) = [m[1,:], m[2:end,end]]
    drop_and_flip(m) = m[end:-1:2, end - 1:-1:1]
    printer(acc, m) = isempty(m) ? vcat(acc[1:end - 1]...) : printer(vcat(acc, m |> top_right), m |> drop_and_flip)
    printer([], m)
end

function spiral_matrix(n::Int)
    (range(1, length = n^2)
      |> x->reshape(x, n, n) 
      |> spiral_matrix_printer # get the order of a spiral matrix
      |> enumerate
      |> collect
      |> xs->sort(xs, by = last) # this positions the index values in to position for spiral array
      |> xs->map(first, xs) 
      |> x->reshape(x, n, n)) # present as matrix
end