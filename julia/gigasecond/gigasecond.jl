import Dates
add_gigasecond(date::DateTime) = DateTime(date) + Dates.Second(1e9)