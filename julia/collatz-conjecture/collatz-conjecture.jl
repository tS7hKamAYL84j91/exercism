using Match

struct Collatz
    start::Int
end

collatz_next(n) = iseven(n) ? n ÷ 2 : 3 * n + 1

Base.IteratorSize(Collatz) = Base.SizeUnknown()

function Base.iterate(iter::Collatz) 
    @match iter.start begin
        1 => (1, nothing)
        n, if n <= 0 end => throw(DomainError("oops"))
        _ => (iter.start, collatz_next(iter.start))
    end
end

function Base.iterate(iter::Collatz, state) 
    @match state begin
        1  => (state, nothing)
        n, if isnothing(n) end => nothing
        _  => (state, collatz_next(state))
    end
end

collatz_steps(n) = (n |> Collatz |> collect |> length) - 1