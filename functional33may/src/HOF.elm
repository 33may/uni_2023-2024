module HOF exposing (..)



----------------------------------------------
repeatUntil: (a -> Bool) -> (a -> a) -> a -> a
repeatUntil condition f init =
    if not (condition init) then
         repeatUntil condition f (f init)
    else
        init

above100: Int -> Bool
above100 x = x > 100

double: Int -> Int
double x = x * 2

-----------------------------------
aboveN: Int -> Int -> Bool
aboveN max val = val >= max

-----------------------------------

calculatePower : Int -> Int -> Int -> Int -> Int
calculatePower val base cur basePow =
    if val <= basePow then
        cur
    else
        calculatePower val base (cur + 1) (basePow * base)


findPower : Int -> Int -> Int
findPower val base =
    calculatePower val base 0 1


calcLog: Int -> Int -> Int
calcLog base val =
    let
        resVal = repeatUntil (aboveN val) ((*) base) 1
    in
    findPower resVal base


-------------------------------------
collaz: List Int -> List Int
collaz list =
    case list of
        [] -> []
        x :: xs ->
            if modBy 2 x == 1 then
                (3 * x + 1) :: x :: xs
            else
                (x // 2) :: x :: xs


collazSequence : Int -> List Int
collazSequence n = repeatUntil myPredicate collaz [n]

myPredicate : List Int -> Bool
myPredicate list = List.head list == Just 1


--collaz: Int -> List Int
--collaz n =
--    if n == 1 then
--        [1]
--    else
--        if modBy 2 n == 1 then
--            n :: collaz (3 * n + 1)
--        else
--            n :: collaz (n // 2)



testRepeatUntilDouble : Bool
testRepeatUntilDouble =
    repeatUntil above100 double 7 == 112

testRepeatUntilIncrement : Bool
testRepeatUntilIncrement =
    repeatUntil above100 ((+) 1) 42 == 101

testRepeatUntilCustomAbove : Bool
testRepeatUntilCustomAbove =
    repeatUntil (aboveN 50) ((*) 2) 3 == 96

testCalcLogBase3Value1 : Bool
testCalcLogBase3Value1 =
    calcLog 3 1 == 0

testCalcLogBase3Of100 : Bool
testCalcLogBase3Of100 =
    calcLog 3 100 == 5

testCalcLogBase3Value27 : Bool
testCalcLogBase3Value27 =
    calcLog 3 27 == 3

testCalcLogBase2Value32 : Bool
testCalcLogBase2Value32 =
    calcLog 2 32 == 5

testCalcLogBase10Value1000 : Bool
testCalcLogBase10Value1000 =
    calcLog 10 1000 == 3

testCollazEmptyList : Bool
testCollazEmptyList =
    collaz [] == []

testCollazSingleElement : Bool
testCollazSingleElement =
    collazSequence 1 == [1]

testCollatzSequenceFor19 : Bool
testCollatzSequenceFor19 =
    collazSequence 19 == [1, 2, 4, 8, 16, 5, 10, 20, 40, 13, 26, 52, 17, 34, 11, 22, 44, 88, 29, 58, 19]

allTestsPassed : Bool
allTestsPassed =
    List.all identity
        [ testRepeatUntilDouble
        , testRepeatUntilIncrement
        , testRepeatUntilCustomAbove
        , testCalcLogBase3Value1
        , testCalcLogBase3Of100
        , testCalcLogBase3Value27
        , testCalcLogBase2Value32
        , testCalcLogBase10Value1000
        , testCollazEmptyList
        , testCollazSingleElement
        , testCollatzSequenceFor19
        ]
