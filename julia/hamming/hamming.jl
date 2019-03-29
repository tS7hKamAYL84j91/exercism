distance(s1::AbstractString, s2::AbstractString) = 
    length(s1) == length(s2) ? count(collect(s1) .!= collect(s2)) : throw(ArgumentError("Oops")) 