/* https://en.wikipedia.org/wiki/Binary_search_algorithm */

let find = (xs, x) => {
  let rec binary_search = (xs, l, r, t) => {
    let m = (l + r) / 2;
    let search = m' =>
      switch (xs[m']) {
      | xs_m when xs_m < t => binary_search(xs, m' + 1, r, t)
      | xs_m when xs_m > t => binary_search(xs, l, r - 1, t)
      | _ => Some(m')
      };
    l > r ? None : search(m);
  };

  binary_search(xs, 0, Array.length(xs) - 1, x);
};