pub fn find() -> Option<u32> {
  let n = 1000;  

  let is_pythagorean = |(a,b,c)| a*a + b*b == c*c;

  let pythagorean_triples = |max_triple| (1..max_triple)
  .flat_map(move |a| (a..max_triple)
    .flat_map(move |b| (b..max_triple)
      .map(move |c| (a,b,c))))
  .filter(|&z| is_pythagorean(z))
  ;

  pythagorean_triples(n)
  .filter(move |&(a,b,c)| a+b+c == n)
  .nth(0)
  .map(|(a,b,c)|a*b*c)
}


