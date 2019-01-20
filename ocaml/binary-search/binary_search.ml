(* https://en.wikipedia.org/wiki/Binary_search_algorithm *)
let rec binary_search xs l r t = 
  let m = (l + r) / 2 in
  if l > r then None else match xs.(m) with
    | xs_m when xs_m < t -> binary_search xs (m + 1) r t
    | xs_m when xs_m > t -> binary_search xs l (r- 1) t
    | _  -> Some m

let find xs x  = binary_search xs 0 (Array.length xs - 1) x


  
  