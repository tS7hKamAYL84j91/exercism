import  Base: +, -
using Match

@enum Direction NORTH EAST SOUTH WEST

struct Point{T <: Number} x::T; y::T; end
Point(x::T, y::T) where {T <: Number} = Point{T}(x, y)

mutable struct Robot
    position::Point
    heading::Direction
    Robot((x, y), d) = new(Point(x, y), d)
    Robot(p::Point, d) = new(p, d)
end

num_directions = Direction |> instances |> length

+(d::Direction, i) = mod(Int(d) + i, num_directions)
-(d::Direction, i) = mod(Int(d) - i, num_directions) 

position(r::Robot) = r.position
heading(r::Robot) = r.heading

turn_right(r::Robot) = Robot(r.position, Direction(r.heading + 1))
turn_right!(r::Robot) = (r.heading = turn_right(r).heading; r)

turn_left(r::Robot) = Robot(r.position, Direction(r.heading - 1))
turn_left!(r::Robot) = (r.heading = turn_left(r).heading; r)

advance(r::Robot) = (@match r.heading begin
    h, if h == NORTH end => Point(r.position.x, r.position.y + 1)
    h, if h == SOUTH end => Point(r.position.x, r.position.y - 1)
    h, if h == EAST end => Point(r.position.x + 1, r.position.y)
    h, if h == WEST end => Point(r.position.x - 1, r.position.y)
end) |> p->Robot(p, r.heading)
advance!(r::Robot) = (r.position = advance(r).position; r)

function move(r::Robot, ms::String) 
    step(r, mv) = @match mv begin
        'L' => turn_left(r)
        'R' => turn_right(r)
        'A' => advance(r)
        _ => r
    end
    reduce(step, ms, init = r)
end

function move!(r, ms) 
    moved_robot = move(r, ms)
    r.heading = moved_robot.heading
    r.position = moved_robot.position
    r
end

