function raindrops(number::Int)::String 
    drops = [ (3, "Pling"), (5, "Plang"), (7, "Plong")]
    sound_of_drops(number, drop, drop_sound) = rem(number, drop) == 0 ? drop_sound : ""
    default_sound(number, drop_sound) = drop_sound  == "" ? string(number) : drop_sound

    (drops
      |> ds->map(drop->sound_of_drops(number, drop...), ds) 
      |> join 
      |> drop_sound->default_sound(number, drop_sound))
end
