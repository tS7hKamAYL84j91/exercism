function to_roman(number::Integer) 
    numerals = Dict([1 => "I", 4 => "IV", 5 => "V", 
      9 => "IX", 10 => "X", 40 => "XL", 50 => "L", 
      90 => "XC", 100 => "C", 400 => "CD", 500 => "D",
      900 => "CM", 1000 => "M"])

    to_roman_reducer((rmdr, xs), x) =  
      rem(rmdr, x), xs * repeat(numerals[x], div(rmdr, x))
    
    number <= 0 ? throw(ErrorException("oops")) :
      (numerals 
        |> keys 
        |> collect 
        |> xs->sort(xs, rev = true) 
        |> xs->reduce(to_roman_reducer, xs, init = (number, ""))
        |> last)
end

