type coins = list(int);

/*
   # Dynamic programming approach; we can build up solutions based on observation
   # the soln for t [i1 ..in] contains a best solution for t - i1 [i1...in] and soln for 0 is []
   # so you can build to the target by calculating the best solutions for all the other numbers
   https://www.hackerrank.com/challenges/coin-generateWaysToMakeChange/problem
 */
let makeChange = (target, coins) => {
  let generateWaysToMakeChange = (waysToMakeChange, target) => {
    let filterCoinsThatMakeChangeForTarget =
      List.filter(coin => Belt.Map.Int.has(waysToMakeChange, target - coin));
    let makeAllPossibleWaysToMakeTarget =
      List.map(c =>
        [c, ...Belt.Map.Int.getExn(waysToMakeChange, target - c)]
      );
    let shortestWay = (c1, c2) =>
      List.length(c1) < List.length(c2) ? c1 : c2;
    let keepShortestWay =
      fun
      | [] => waysToMakeChange
      | [x, ...xs] =>
        Belt.Map.Int.set(
          waysToMakeChange,
          target,
          List.fold_left(shortestWay, x, xs) |> List.sort(compare),
        );
    coins
    |> filterCoinsThatMakeChangeForTarget
    |> makeAllPossibleWaysToMakeTarget
    |> keepShortestWay;
  };
  let baseCaseWaysToMakeChange: Belt.Map.Int.t(list(int)) =
    [|(0, [])|]->Belt.Map.Int.fromArray;

  Belt.(
    Array.range(1, target)
    ->Array.reduce(baseCaseWaysToMakeChange, generateWaysToMakeChange)
    ->Map.Int.get(target)
  );
};