use chrono::{DateTime, Duration, Utc};

// Returns a Utc DateTime one billion seconds after start.
pub fn after(start: DateTime<Utc>) -> DateTime<Utc> {
  start
    .checked_add_signed(Duration::seconds(i64::pow(10, 9)))
    .unwrap()
}
