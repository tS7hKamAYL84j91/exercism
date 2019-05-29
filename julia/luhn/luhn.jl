function luhn(input::String) 
    is_valid(input) = (input |> xs->isdigit.(xs) |> all) && (input |> length) > 1 
    luhn_digit((i, x)) = iseven(i) ? x * 2 % 9 : x
    luhn_sum(xs) = xs |> reverse |> enumerate |> xs′->luhn_digit.(xs′) |> sum
    luhn_check(input) = (input |> xs->parse.(Int, xs) |> luhn_sum) % 10 == 0

    replace(input, " " => "") |> collect |> ns->is_valid(ns) && luhn_check(ns)
end