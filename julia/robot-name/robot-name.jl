using Random, Dates

rng = now() |> millisecond |> MersenneTwister
rand_name() = Random.randstring(rng, 'A':'Z', 2) * Random.randstring(rng, '1':'9', 3)

mutable struct Robot
    name::String
    Robot() = new(rand_name())
end

reset!(instance::Robot) = instance.name = rand_name();