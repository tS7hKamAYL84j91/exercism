let is_valid_nanp str =  
  let nanp_regex = 
    Str.regexp {|^\(\+1\|1\)?[-. ]*(?[2-9][0-9][0-9])?[-. ]*(?[2-9][0-9][0-9])?[-. ]*(?[0-9][0-9][0-9][0-9])*$|} in
  Str.string_match nanp_regex (Base.String.strip str) 0 

let number str =  
  match (is_valid_nanp str) with
  | true -> Some (Str.global_replace (Str.regexp {|^\(\+1\|1\)\|[.() -]|}) "" str)
  | false -> None
