module Card exposing (..)

--------------- Week/Card
--------------- Anton Novokhatskiн

-- commands to test:    import Card exposing (..)
--                      allTests || allTestsPassed

valid : String -> Bool
valid s =
    let
        list = stringToIntList s
    in
    list
        |> step1
        |> step2
        |> (\result -> result == 0)


listReverse: List Int -> List Int
listReverse list =
    case list of
        [] -> []
        x::xs -> listReverse xs ++ [x]

step1: List Int -> Int
step1 list =
    listReverse list
    |> List.indexedMap (\index n -> if modBy 2 index == 1 then n * 2 else n)
    |> List.foldr (\n acc -> acc + (if n > 9 then n - 9 else n)) 0

step2: Int -> Int
step2 prev = modBy 10 prev

charToInt : Char -> Int
charToInt char =
    Char.toCode char - Char.toCode '0'

-- Converts a string of digits into a list of Ints
stringToIntList : String -> List Int
stringToIntList s =
    let
        list = String.toList s
    in
        List.filter Char.isDigit list
        |> List.map charToInt


numValid: List String -> Int
numValid numbers =
    List.foldl (\n acc -> if valid n then acc + 1 else acc) 0 numbers


-- Test functions for `valid`
testValid1 : Bool
testValid1 = valid "4012888888881881" == True

testValid2 : Bool
testValid2 = valid "5391234567890123" == False

testValid3 : Bool
testValid3 = valid "6011123456789012" == False

testValid4 : Bool
testValid4 = valid "371234567890123" == False

testValid5 : Bool
testValid5 = valid "30569309025904" == True

testNumValid: Bool
testNumValid = numValid ["4012888888881881", "5391234567890123", "6011123456789012", "371234567890123", "30569309025904"] == 2

allTestsValid : List Bool
allTestsValid = [ testValid1, testValid2, testValid3, testValid4, testValid5, testNumValid ]

allValidTestsPassed : Bool
allValidTestsPassed = List.all identity allTestsValid

allTests : List (List Bool)
allTests = [ allTestsValid ]
