module Merge exposing (..)


-- until we just have some unsorted list we doesnt care about how the order change. all we need is split at middle
splitHelper: List comparable -> (List comparable, List comparable)
splitHelper list =
   case list of
     [] ->
       ( [], [] )
     front :: rest ->
       let
         (halfOne, halfTwo) = splitHelper rest
       in
         ( halfTwo, front :: halfOne )


merge : List comparable -> List comparable -> List comparable
merge list1 list2 =
    case (list1, list2) of
        ([], []) -> []
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
                leftS = mergeSort left
                rightS = mergeSort right
            in
                merge leftS rightS


testMergeSortEmptyList : Bool
testMergeSortEmptyList =
    mergeSort [] == []

testMergeSortSingleElement : Bool
testMergeSortSingleElement =
    mergeSort [1] == [1]

testMergeSortAlreadySorted : Bool
testMergeSortAlreadySorted =
    mergeSort [1, 2, 3, 4, 5] == [1, 2, 3, 4, 5]

testMergeSortUnsortedList : Bool
testMergeSortUnsortedList =
    mergeSort [3, 1, 4, 1, 5, 9, 2, 6] == [1, 1, 2, 3, 4, 5, 6, 9]

-- Test list with negative numbers
testMergeSortNegativeNumbers : Bool
testMergeSortNegativeNumbers =
    mergeSort [-3, -1, -4, -1, -5, -9, -2, -6] == [-9, -6, -5, -4, -3, -2, -1, -1]

testMergeSortWithDuplicates : Bool
testMergeSortWithDuplicates =
    mergeSort [5, 3, 5, 3, 1] == [1, 3, 3, 5, 5]

allTests : List Bool
allTests =
    [ testMergeSortEmptyList
    , testMergeSortSingleElement
    , testMergeSortAlreadySorted
    , testMergeSortUnsortedList
    , testMergeSortNegativeNumbers
    , testMergeSortWithDuplicates
    ]

allTestsPassed : Bool
allTestsPassed = List.all identity allTests