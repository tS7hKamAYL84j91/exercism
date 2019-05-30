apply(square, f) = 1 <= square <= 64 ? f(square) : throw(DomainError("oops"))
on_square(square) =  apply(square, s->Int128(1) << (s - 1)) # replace with bit shift Int128(2)^(s - 1)) 
total_after(square) = apply(square, s->(Int128(1) << s) - 1)  # replace with bit shift and some fancy maths mapfoldl(on_square, (+), 1:s))