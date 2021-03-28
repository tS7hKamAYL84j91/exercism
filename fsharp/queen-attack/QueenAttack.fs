module QueenAttack

let create (row, col) =
    let posIsValid (row) = (row >= 0 && row < 8)
    posIsValid row && posIsValid col

let canAttack (q1row, q1col) (q2row, q2col) =
    q1row = q2row
    || q1col = q2col
    || abs (q2row - q1row) = abs (q2col - q1col)
