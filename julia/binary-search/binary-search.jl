using Match

function binarysearch(as, t; rev::Bool = false, by = identity, lt = <) # Julia function to do this searchsorted
    function bin_search(as::Array{S}, l::Int64, r::Int64, t::T) where {S,T <: Number}
        # recursive implementation of https://en.wikipedia.org/wiki/Binary_search_algorithm
        @match (as, l, r, t) begin
            ([], _, _, _) => (1, 0)
            (_as, l, r, _t), if l > r end  => (l, r)
            (as, l, r,  t), if lt(as[div(l + r, 2)], t) end => bin_search(as, div(l + r, 2) + 1, r, t)
            (as, l, r,  t), if !lt(as[div(l + r, 2)], t) && !isequal(as[div(l + r, 2)], t) end => bin_search(as, l, div(l + r, 2) - 1, t)
            (_as, l, r, _t) =>  (div(l + r, 2), div(l + r, 2))
        end
    end
    
    

    (by.(as) 
    |> as->bin_search(sort(as, lt = lt), 1, length(as), by(t)) 
    |> re->(rev ? (length(as) - re[2] + 1, length(as) - re[1] + 1) : re)
    |> re′->re′[1]:re′[2])
end