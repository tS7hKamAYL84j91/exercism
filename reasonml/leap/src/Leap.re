
let isDivisibleBy = (year, value) =>  year mod value == 0;

let isLeapYear = year =>
  switch (year) {
    | year when isDivisibleBy(year, 400) => true
    | year when isDivisibleBy(year, 100) => false
    | year when isDivisibleBy(year, 4) => true
    | _ => false
  };
