let phoneNumber = str => {
  /* See http://regexlib.com/Search.aspx?k=nanp */
  let nanp_regex = [%re
    {|/^\s*(?:\+1|1)?[\s.-]*\(?([2-9]\d{2})\)?[\s.-]*\(?([2-9]\d{2})\)?[\s.-]*\(?(\d{4})\)?\s*$/|}
  ];
  Js.String.match(nanp_regex, str)
  ->Belt.Option.map(arr => arr[1] ++ arr[2] ++ arr[3]);
};