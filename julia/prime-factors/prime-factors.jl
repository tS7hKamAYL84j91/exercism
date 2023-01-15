function prime_factors(n)
  reducer(acc, x) = vcat(factorise(quotient(n, acc), x)..., acc...)
  n <= 1 ? [] : reduce(reducer, sqrt_flr(n) |> wheel, init=[]) |> xs -> include_prime_quotient(n, xs) |> sort

end

sqrt_flr = Int ∘ floor ∘ sqrt
factorise(n, x) = n <= 1 ? [] : n % x == 0 ? [x, factorise(n ÷ x, x)...] : []
include_prime_quotient(n, xs) = isempty(xs) ? [n] : quotient(n, xs) == 1 ? xs : [quotient(n, xs), xs...]
quotient(n, xs) = reduce(div, xs, init=n)

#wheel factorisation https://en.wikipedia.org/wiki/Wheel_factorization
function wheel(n)
  basis = [2, 3, 5]
  spoke = [7, 11, 13, 17, 19, 23, 29, 31]
  [basis..., mapreduce(x -> (x * 30) .+ spoke, vcat, 0:(n÷30))...]
end
