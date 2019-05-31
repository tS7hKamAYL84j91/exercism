apply_to_valid(square, f) = 1 <= square <= 64 ? f(square) : throw(DomainError("oops"))
on_square(square) =  apply_to_valid(square, s->UInt64(1) << (s - 1))        # replace with bit shift Int128(2)^(s - 1)) 
total_after(square) = apply_to_valid(square, s->(UInt64(1) << s) - 1)       # replace with bit shift and some fancy maths mapfoldl(on_square, (+), 1:s))