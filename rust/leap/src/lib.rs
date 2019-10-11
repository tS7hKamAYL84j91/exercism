pub fn is_leap_year(year: u64) -> bool {
  let div_by = |year, n| year % n == 0;
  match year {
    year if div_by(year, 400) => true,
    year if div_by(year, 100) => false,
    year if div_by(year, 4) => true,
    _ => false,
  }
}
