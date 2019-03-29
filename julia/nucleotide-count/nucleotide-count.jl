function count_nucleotides(strand::AbstractString)
  counters = Dict(['A', 'C', 'G', 'T'] .=> 0)
  reducer(acc, x) =  x in keys(acc) ? merge(acc, Dict(x => acc[x] + 1)) : throw(DomainError(nothing))
  collect(strand) |> xs -> reduce(reducer, xs, init=counters)
end

