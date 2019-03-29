is_triangle(sides) = length(sides) == 3 && minimum(sides) > 0 && sort(sides) |> a -> a[3] <= a[1] + a[2]
unique_values(xs, comp, x) = comp(xs |> Set |> length, x)

is_equilateral(sides) = is_triangle(sides) && unique_values(sides, (==), 1)
is_isosceles(sides)   = is_triangle(sides) && unique_values(sides, (<=), 2)
is_scalene(sides)     = is_triangle(sides) && unique_values(sides, (==), 3)

