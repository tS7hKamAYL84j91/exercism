let square_of_sum n = let sum = n * (n + 1) / 2 in sum * sum 
let sum_of_squares n = n * (n + 1) * (2 * n +1) / 6 (* https://en.wikipedia.org/wiki/Square_pyramidal_number *)
let difference_of_squares n = square_of_sum n - sum_of_squares n