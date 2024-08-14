module Class exposing (..)

f1: Int -> Int
f1 = (\a -> a * 2)


f2: Int -> Int
f2 = (\a -> a * a - (a - 1) * (a - 1))

funcList = [f1, f2, (\a -> a - 3)]


apply: Int ->  List (Int -> Int) -> List Int
apply n list=
    List.map (\m -> m n ) list



module Merge exposing (..)


splitHelper: List comparable -> (List comparable, List comparable)
splitHelper list =
    case list of
        [] -> ([],[])
        [x] -> ([],[])
        head :: tail ->
            let
                middle = List.length list // 2
                left = List.take middle list
                right = List.drop middle list
            in
                (left, right)



merge : List comparable -> List comparable -> List comparable
merge list1 list2 =
    case (list1, list2) of
        (_, []) -> list1
        ([], _) -> list2
        (x :: xs, y :: ys) ->
            if x <= y then
                x :: merge (y :: ys) xs
            else
                y :: merge (x :: xs) ys


mergeSort : List comparable -> List comparable
mergeSort list =
    case list of
        [] -> []
        [x] -> [x]
        _ ->
            let
                (left, right) = splitHelper list
                sortedLeft = mergeSort left
                sortedRight = mergeSort right
            in
            merge sortedLeft sortedRight

