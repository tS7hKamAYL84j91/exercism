using Match

function triangle(num::Int)
    function cell(n, k) 
        @match (n, k) begin
            (_, 0) => 1
            (n, k) => div(cell(n, k - 1) * (n + 1 - k), k)
        end
    end
    num < 0 ? throw(DomainError(nothing)) : 
      [[cell(row, col) for col in  0:row] for row in 0:(num - 1)]
end
