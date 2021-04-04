(ns triangle)

(defn is-valid? [a b c number-of-sides-comparison-fn number-of-sides-same-length]
  (->> (list a b c)
       (sort-by #(* -1 %))
       (#(and (> (apply min %) 0) (<= (first %) (reduce + (rest %)))
              (number-of-sides-comparison-fn (count (distinct (list a b c))) number-of-sides-same-length)))))

(defn equilateral? [a b c] (is-valid? a b c = 1))
(defn isosceles? [a b c] (is-valid? a b c <= 2))
(defn scalene? [a b c] (is-valid? a b c = 3))

