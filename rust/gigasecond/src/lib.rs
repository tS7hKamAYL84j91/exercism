use chrono::{DateTime, Duration, Utc};

const GIGASECONDS: i64 = 1e9 as i64;

// Returns a Utc DateTime one billion seconds after start.
pub fn after(start: DateTime<Utc>) -> DateTime<Utc> {
  start + Duration::seconds(GIGASECONDS)
}
