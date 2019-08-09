import Base: promote_rule, ≈, ==, exp, abs, conj, +, *, -, ^, /

struct ComplexNumber{T <: Real} <: Number
    r ::T
    jm::T
end

ComplexNumber(x::Real) = ComplexNumber(x, zero(x)) 
ComplexNumber(x::Real, y::Real) = ComplexNumber(promote(x, y)...)

real(z::ComplexNumber) = z.r
imag(z::ComplexNumber) = z.jm

ComplexNumber{T}(x::Real) where {T<:Real}  = ComplexNumber{T}(x, zero(x))
ComplexNumber{T}(z::ComplexNumber) where {T<:Real}  = ComplexNumber{T}(real(z), imag(z)) 

promote_rule(::Type{ComplexNumber{T}}, ::Type{S}) where {T<:Real,S<:Real} = ComplexNumber{promote_type(T,S)}
promote_rule(::Type{ComplexNumber{T}}, ::Type{ComplexNumber{S}}) where {T<:Real,S<:Real} = ComplexNumber{promote_type(T,S)}

const jm = ComplexNumber(0, 1)

function show(io::IO, z::ComplexNumber)
  r, j  = real(z), imag(z)
  show(r)
  print(io, " $(j < 0 ? "-" : "+") ")
  show(abs(j))
  print(io, "jm")
end

==(z::ComplexNumber, w::ComplexNumber) = real(z) == real(w) && imag(z) == imag(w)
≈(z::ComplexNumber, w::ComplexNumber) = isapprox(real(z),real(w), atol=1e-5) && isapprox(imag(z),imag(w), atol=1e-5)

conj(z::ComplexNumber) = ComplexNumber(real(z), -imag(z))
abs(z::ComplexNumber) = hypot(real(z), imag(z))
exp(z::ComplexNumber) = ComplexNumber(exp(real(z))) * ComplexNumber(cos(imag(z)), sin(imag(z)))

+(z::ComplexNumber, w::ComplexNumber) = ComplexNumber(real(z) + real(w), imag(z) + imag(w))
-(z::ComplexNumber, w::ComplexNumber) = ComplexNumber(real(z) - real(w), imag(z) - imag(w))
*(z::ComplexNumber, w::ComplexNumber) = ComplexNumber(real(z) * real(w) - imag(z) * imag(w), imag(z) * real(w) + real(z) * imag(w))
^(z::ComplexNumber, e::Int64) = reduce(*, z for i in 1:e) 
/(z::ComplexNumber, w::ComplexNumber) = ComplexNumber((real(z) * real(w) + imag(z) * imag(w) ) / (real(w)^2 + imag(w)^2), 
  (imag(z) * real(w) - real(z) * imag(w)) / (real(w)^2 + imag(w)^2))




