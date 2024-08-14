module Week3.Split exposing (..)

split: (a -> Bool) -> List a -> (List a, List a)
split f list =
    case list of
        [] ->
            ([],[])
        x :: xs ->
            let
                (left, right) = split f xs
            in
            if f x then
                (left, x :: right)
            else
                (x :: left, right)



split2: (a -> Bool) -> List a -> (List a, List a)
split2 f list =
    let
       right = List.filter f list
       left = List.filter (not << f) list
    in
    (left, right)