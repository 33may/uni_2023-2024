module Exam exposing (..)

-- FUNCTION COMPOSITION AND PIPELINING

-- Composition
increment : Int -> Int
increment n = n + 1

double : Int -> Int
double n = n * 2

composeExample : Int -> Int
composeExample = increment >> double

-- Pipelining
pipelineExample : Int
pipelineExample = 5 |> increment |> double


--1,2,3,4]
--1 :: [2,3,4]
--1 :: 2 :: 3 :: 4 :: []



--case maybeList of
--    Just xs -> xs
--    Nothing -> []
--
--  case xs of
--    [] ->
--      Nothing
--    first :: rest ->
--      Just (first, rest)
--
--  case n of
--    0 -> 1
--    1 -> 1
--    _ -> fib (n-1) + fib (n-2)




-- create records

--origin = { x = 0, y = 0 }
--point = { x = 3, y = 4 }
--
---- access fields
--origin.x == 0
--point.x == 3
--
---- field access function
--List.map .x [ origin, point ] == [ 0, 3 ]
--
---- update a field
--{ point | x = 6 } == { x = 6, y = 4 }
--
---- update many fields
--{ point | x = point.x + 1, y = point.y + 1 }
--
--
--
--square =
--  \n -> n^2
--
--squares =
--  List.map (\n -> n^2) (List.range 1 100)





viewNames1 names =
  String.join ", " (List.sort names)

viewNames2 names =
  names
    |> List.sort
    |> String.join ", "

-- (arg |> func) is the same as (func arg)
-- Just keep repeating that transformation!



-- alias for appending lists and two lists
append xss yss = xs ++ ys
xs = [1,2,3]
ys = [4,5,6]

-- All of the following expressions are equivalent:
a1 = append xs ys
a2 = xs ++ ys

b2 = (++) xs ys

c1 = (append xs) ys
c2 = ((++) xs) ys




map : (a -> b) -> List a -> List b
List.map (\x -> x * 2) [1, 2, 3]

filter : (a -> Bool) -> List a -> List a
List.filter (\x -> x > 1) [1, 2, 3]  -- Result: [2, 3]


foldl : (a -> b -> b) -> b -> List a -> b
List.foldl (+) 0 [1, 2, 3]  -- Result: 6


foldr : (a -> b -> b) -> b -> List a -> b
List.foldr (+) 0 [1, 2, 3]  -- Result: 6


length : List a -> Int

reverse : List a -> List a

append : List a -> List a -> List a

concat : List (List a) -> List a


--ny: Checks if any element in a list satisfies a predicate.
any : (a -> Bool) -> List a -> Bool

--all: Checks if all elements in a list satisfy a predicate.
all : (a -> Bool) -> List a -> Bool






