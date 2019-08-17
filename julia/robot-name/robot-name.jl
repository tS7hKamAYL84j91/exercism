using Random

seq(xs,l) = xs |> collect |> xs->Random.randstring(xs,l)
rand_name() = seq('A':'Z',2) * seq('1':'9',3)

mutable struct Robot
  name:: String
  Robot() = new(rand_name())
end

function reset!(instance::Robot)
  instance.name = rand_name()
  instance
end

