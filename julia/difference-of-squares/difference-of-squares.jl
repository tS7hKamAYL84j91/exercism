square_of_sum(n::Int) = (n * (n + 1) ÷ 2)^2
sum_of_squares(n::Int) = n * (n + 1) * (2 * n + 1) ÷ 6
difference(n::Int) = square_of_sum(n) - sum_of_squares(n)