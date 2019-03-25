function count_nucleotides(strand::AbstractString)
  counters = Dict('A' => 0, 'C' => 0, 'G' => 0, 'T' => 0)

  nucleotide_counter(acc, x) =
    if (x in Base.keys(acc)) Base.merge(acc, Base.Dict(x => acc[x] + 1)) else throw(DomainError(nothing)) end
  
  collect(strand) |> xs -> reduce(nucleotide_counter, xs,  init=counters)
end

