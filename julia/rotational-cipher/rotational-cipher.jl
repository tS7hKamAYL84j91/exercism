function rotate(shift::Int, chr::Char)
    base = islowercase(chr) ? 'a' : 'A'
    isletter(chr) ? mod(chr - base + shift, 26) + base : chr
end

rotate(shift::Int, str::String) = 
  str |> collect |> xs->map(chr->rotate(shift, chr), xs) |> join

for shift in 0:26
    macro_name = Symbol("R" * string(shift) * "_str")
    eval(quote(macro $macro_name(p) rotate($shift, p) end) end)
end