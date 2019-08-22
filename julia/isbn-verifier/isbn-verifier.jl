import Base: isvalid, ==, string, show

struct ISBN <: AbstractString
    isbn::String
    ISBN(xs) = !isvalid(ISBN, xs) ? 
      throw(ArgumentError("oops")) : new(replace(xs, "-" => ""))
end

macro isbn_str(xs) ISBN(xs) end

string(s::ISBN) = s.isbn
show(io::IO, str::ISBN) = print(io, str.isbn)

isvalid(::Type{ISBN}, xs)  = (
    !occursin(r"^(\d-?){9}(\d|X)$", xs) ? false :
      (replace(xs, "-" => "")
      |> xs->zip(xs, 10:-1:1)
      |> xs->map(x->x[1] == 'X' ? 10 * x[2] : parse(Int, x[1]) * x[2], xs)
      |> sum) % 11 == 0)