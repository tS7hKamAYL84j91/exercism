function to_rna(dna::AbstractString)
    (collect(dna) 
        |> ns -> map(n -> get(Dict(['G','C','T','A'] .=> ['C','G','A','U']), n, :error), ns) 
        |> ns -> any(n -> n == :error, ns) ? throw(ErrorException("oops")) : ns |> join)
end

