using Match

shouting(stimulus) = uppercase(stimulus) == stimulus && any(isletter,stimulus)
question(stimulus) = endswith(stimulus,"?")
silence(stimulus) = isempty(stimulus) 

function bob(stimulus::AbstractString) 
  @match stimulus |> strip begin
    s, if shouting(s) && question(s) end => "Calm down, I know what I'm doing!"
    s, if shouting(s) end => "Whoa, chill out!"
    s, if question(s) end => "Sure."
    s, if silence(s) end => "Fine. Be that way!"
    _ => "Whatever."
  end
end

