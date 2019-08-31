import Base: isempty, in, issubset, ==, push!, intersect!, 
  intersect, union, union!, length, iterate, copy  

struct CustomSet{T} <: AbstractSet{T} 
    set::Array{T,1}
    CustomSet{T}() where {T} = new(Array{T,1}())
    CustomSet{T}(cs::Array{T,1}) where {T} = new(Array{T,1}(cs |> unique))
end

CustomSet() = CustomSet{Any}()
CustomSet(xs::Array{T,1}) where {T} = CustomSet{T}(xs)

isempty(cs::CustomSet) = isempty(cs.set)

in(x::Any, cs::CustomSet) = x in cs.set

issubset(cs₁::CustomSet, cs₂::CustomSet) = issubset(cs₁.set, cs₂.set) 
==(cs₁::CustomSet, cs₂::CustomSet) = (issubset(cs₁, cs₂) && issubset(cs₂, cs₁)) || (isempty(cs₁) && isempty(cs₂))

push!(cs::CustomSet, x::Any) = (!(x in cs) ? push!(cs.set, x) : nothing; cs)

intersect(cs₁::CustomSet, cs₂::CustomSet) = intersect(cs₁.set, cs₂.set) |> CustomSet
intersect!(cs₁::CustomSet, cs₂::CustomSet) = (intersect!(cs₁.set, cs₂.set);cs₁)

disjoint(cs₁::CustomSet, cs₂::CustomSet) = intersect(cs₁, cs₂) |> isempty

complement(cs₁::CustomSet, cs₂::CustomSet) = setdiff(cs₁.set, cs₂.set) |> CustomSet
complement!(cs₁::CustomSet, cs₂::CustomSet) = (setdiff!(cs₁.set, cs₂.set); cs₁)

union(cs₁::CustomSet, cs₂::CustomSet) = union(cs₁.set, cs₂.set) |> CustomSet
union!(cs₁::CustomSet, cs₂::CustomSet) = (union!(cs₁.set, cs₂.set) |> unique!; cs₁)

length(cs::CustomSet) = length(cs.set)

iterate(cs::CustomSet, i...) = iterate(cs.set, i...)

copy(cs::CustomSet) = cs.set |> CustomSet