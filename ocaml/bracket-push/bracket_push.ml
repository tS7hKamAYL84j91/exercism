
let brackets = [
  ('(', ')'); 
  ('[', ']'); 
  ('{', '}');
  ]

let is_bracket f chr= brackets |> List.map f |> List.exists ((=) chr)
let is_opening_bracket = is_bracket fst
let is_closing_bracket = is_bracket snd

let matched_pair opening closing = 
   brackets |> Base.List.find ~f: (fun x -> snd x = closing) |> Base.Option.map ~f:fst = Some opening

let pop_nested_pair stack closing = match stack with 
  | (hd::tl) when matched_pair hd closing -> tl
  | _ -> closing :: stack

let bracket_stack stack chr = match (stack, chr) with
  | (stack, chr) when is_opening_bracket chr -> chr :: stack
  | (stack, chr) when is_closing_bracket chr -> pop_nested_pair stack chr
  | _ -> stack

let are_balanced str = str |> Base.String.to_list |> List.fold_left bracket_stack [] = [];;