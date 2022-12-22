module InterestIsInteresting

let interestRate (balance: decimal) : single =
    match balance with
    | _ when balance < 0m -> 3.213f
    | _ when balance < 1000m -> 0.5f
    | _ when balance < 5000m -> 1.621f
    | _ -> 2.475f

let interest (balance: decimal) : decimal =
    decimal (interestRate balance) * balance / 100m

let annualBalanceUpdate (balance: decimal) : decimal = interest balance + balance

let amountToDonate (balance: decimal) (taxFreePercentage: float) : int =
    decimal taxFreePercentage * balance * 2.0m / 100.0m
    |> floor
    |> int
    |> max 0 // in case of negative balance
