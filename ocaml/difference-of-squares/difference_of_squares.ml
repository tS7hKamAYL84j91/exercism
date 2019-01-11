let fold_range f n = Base.List.range 1 (n + 1) |> List.fold_left (fun acc x -> acc + f x ) 0

let square_of_sum n = let sum = fold_range (fun x -> x) n in sum * sum 

let sum_of_squares n = fold_range (fun x -> x * x) n 

let difference_of_squares n = square_of_sum n - sum_of_squares n