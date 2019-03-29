parser(regex, s, codec) = eachmatch(regex,s) |> collect |> xs -> map(codec ,xs) |> join

encode(s) = parser(r"(.)\1*", s, m -> "$(length(m.match) > 1 ? length(m.match) : "" )$(m.match |> first)")
decode(s) = parser(r"(\d*)([\w\s])", s, m -> m.captures[2] ^ (isempty(m.captures[1]) ? 1 : parse(Int,m.captures[1])))

