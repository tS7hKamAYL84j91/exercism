(ns leap)

(defn is-divisible-by? [n m] (zero? (mod n m)))

(defn leap-year? [year]
  (or (is-divisible-by? year 400)
      (and (is-divisible-by? year 4) (not (is-divisible-by? year 100)))))
