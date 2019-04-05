function detect_anagrams(subject::AbstractString, candidates::AbstractArray)
    normalise(s) = s |> lowercase |> collect |> sort
    isanagram(s₁, s₂) = lowercase(s₁) != lowercase(s₂) && normalise(s₁) == normalise(s₂)
    filter(c -> isanagram(subject, c), candidates)    
end

