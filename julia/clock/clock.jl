import Base: +, -, show
using Match, Dates

const mins_in_day = 24 * 60

struct Clock
  minutes :: Int64
  function Clock(mm::Int64) 
    modulo_mins(mm) = @match rem(mm, mins_in_day) begin
      r, if r < 0 end => r + mins_in_day  
      r => r
    end
    new(mm |> modulo_mins)
  end
end

Clock(hh::Int64,mm::Int64) = Clock(hh * 60 + mm)

function show(io::IO, clock::Clock)
  fmt_time(mm, f) =  f(mm, 60) |>  t->lpad(t,2,"0")
  print(io,"\"$(fmt_time(clock.minutes,div)):$(fmt_time(clock.minutes,rem))\"")
end

+(clock::Clock, mm:: Dates.Minute) = Clock(clock.minutes + Dates.value(mm))
-(clock::Clock, mm:: Dates.Minute) = Clock(clock.minutes - Dates.value(mm))