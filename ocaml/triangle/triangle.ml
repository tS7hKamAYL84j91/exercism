let is_triangle a b c = 
  max a (max b c) <  a + b + c - (max a (max b c))

let is_equilateral a b c = 
  (a = b && b = c) && is_triangle a b c

let is_isosceles a b c = 
  (a = b || b = c || c = a) && is_triangle a b c

let is_scalene a b c =  
  not (is_isosceles a b c) && is_triangle a b c

