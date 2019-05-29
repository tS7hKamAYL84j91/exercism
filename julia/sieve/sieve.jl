using Match

function sieve(limit::Integer)::Array{Int64,1}
    prime₁ = 2
    erato(acc, x) = (rem.(x, acc) |> xs->any(iszero, xs)) ? acc : vcat(acc, x)
    @match limit begin
        l, if l < prime₁ end => []
        l, if l == prime₁ end => [prime₁]
        _ => foldl(erato, prime₁:limit, init = [prime₁])
    end
end
