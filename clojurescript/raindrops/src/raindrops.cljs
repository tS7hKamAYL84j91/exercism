(ns raindrops)

(def sound-of-rain '((3 "Pling")
                     (5 "Plang")
                     (7 "Plong")))

(defn convert [number]
  (->> sound-of-rain (filter #(zero? (mod number (first %1))))
       (map second)
       (reduce str)
       (#(if (empty? %) (str number) (reduce str %)))))
