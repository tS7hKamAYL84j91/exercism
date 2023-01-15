annotate(minefield) = minefield == [] || minefield == [""] ? minefield :
                      create_mf_mtx(minefield) |> sum_adj_cells |> A -> rebuild_mf(A, create_mf_mtx(minefield))

create_mf_mtx(minefield) =
  hcat(split.(minefield, "")...) |> A -> reshape(A, length(minefield[1]), length(minefield)) |> A -> replace.(A, " " => 0, "*" => 1) |> A -> parse.(Int32, A)

# Note hcat creates cols out of the input minefield rows so we need to use eachcol to get rows back out for the end result
rebuild_mf(sum_of_mines, minefield_matrix) =
  map(x -> annotate_cell(sum_of_mines, minefield_matrix, x[1], x[2]), enumerate_cells(minefield_matrix)) |> A -> map(xs -> join(xs, ""), eachcol(A))

annotate_cell(sum_of_mines, minefield_matrix, i, j) = minefield_matrix[i, j] == 1 ? "*" : sum_of_mines[i, j] == 0 ? " " : string(sum_of_mines[i, j])

sum_adj_cells(A) = map(x -> cell_sum_adj_cells(A, x[1], x[2]), enumerate_cells(A))
cell_sum_adj_cells(A, i, j) = sum(A[max(1, i - 1):min(size(A)[1], i + 1), max(1, j - 1):min(size(A)[2], j + 1)]) - A[i, j]
enumerate_cells(A) = [(i, j) for i in 1:size(A)[1], j in 1:size(A)[2]]
