using Match
import Base: promote_rule, ==, abs, +, *, -, ^, /, show, zero, one, <, <=

struct RationalNumber{T <: Integer} <: Real
    num::T
    den::T
    RationalNumber{T}(num::Integer, den::Integer) where T <: Integer = 
      den == zero(T) ? throw(ArgumentError("$(num), $(den)")) : 
      new((sign(den) * num / gcd(num, den)), abs(den) / gcd(num, den))
end

RationalNumber(num::T, den::T) where {T <: Integer} = RationalNumber{T}(num, den)
RationalNumber(num::Integer, den::Integer) = RationalNumber(promote(num, den)...)
RationalNumber(a::Integer) = RationalNumber(a, one(a)) 
RationalNumber{T}(a::Integer) where {T <: Real}  = RationalNumber{T}(a, one(a))
RationalNumber{T}(a::RationalNumber) where {T <: Real}  = RationalNumber{T}(a.num, a.den) 

promote_rule(::Type{RationalNumber{T}}, ::Type{S}) where {T <: Real,S <: Real} = RationalNumber{promote_type(T, S)}

zero(::Type{RationalNumber}) = RationalNumber(0)
one(::Type{RationalNumber}) = RationalNumber(1)

numerator(a::RationalNumber) = a.num
denominator(a::RationalNumber) = a.den

function show(io::IO, a::RationalNumber)
    show(io, a.num)
    if a.den != 1 
        print(io, "//") 
        show(io, a.den)
    end
end

+(a::RationalNumber, b::RationalNumber) = RationalNumber(a.num * b.den + b.num * a.den, a.den * b.den)
-(a::RationalNumber, b::RationalNumber) = RationalNumber(a.num * b.den - b.num * a.den, a.den * b.den)
*(a::RationalNumber, b::RationalNumber) = RationalNumber(a.num * b.num, a.den * b.den)
/(a::RationalNumber, b::RationalNumber) = RationalNumber(a) * RationalNumber(b.den, b.num)

^(a::RationalNumber, e::Int64) = @match e begin
    0 => RationalNumber(1)
    e, if e < 0 end  => reduce(*, 1 / a for i in 1:abs(e))
    e  => reduce(*, a for i in 1:e)
end
^(a::RationalNumber, e::Float64) = a.num^e / a.den^e
^(a::Real, e::RationalNumber) = (Float64(a)^e.num)^(1 / e.den)

abs(a::RationalNumber) = RationalNumber(abs(a.num), a.den)

==(a::RationalNumber, b::RationalNumber) = (a.den == b.den) && (a.num == b.num)
<(a::RationalNumber, b::RationalNumber) = (a.den == b.den) ? (a.num < b.num) : widemul(a.num, b.den) < widemul(a.den, b.num)
<=(a::RationalNumber, b::RationalNumber) = a == b || a < b