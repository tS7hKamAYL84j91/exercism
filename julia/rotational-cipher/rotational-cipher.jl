# submit
using Match

function rotate(shift::Int, chr::Char)
    @match chr begin
        chr, if chr ∈ 'a':'z' end => mod(chr - 'a' + shift, 26) + 'a'
        chr, if chr ∈ 'A':'Z' end => mod(chr - 'A' + shift, 26) + 'A'
        chr => chr
    end
end

rotate(shift::Int, str::String) = 
  str |> collect |> xs->map(chr->rotate(shift, chr), xs) |> join

for shift in 1:26
    macro_name = Symbol("R" * string(shift) * "_str")
    eval(quote(macro $macro_name(p) rotate($shift, p) end) end)
end