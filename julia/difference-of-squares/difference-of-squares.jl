"""
Sum the squares of the numbers up to the given number
"""
square_of_sum(n::Int) = Int((n * (n + 1) / 2 )^2)

"""
Square the sum of the numbers up to the given number
"""
sum_of_squares(n::Int) = Int(n * (n + 1) * (2 * n + 1) / 6)

"""
Subtract sum of squares from square of sums
"""
difference(n::Int) = square_of_sum(n) - sum_of_squares(n)

