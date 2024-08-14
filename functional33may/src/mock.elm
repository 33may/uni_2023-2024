module Mock exposing (..)

diffOne : List a -> List a -> Bool
diffOne xs ys =
    diffOneHelper xs ys False

-- Helper function that carries a flag indicating if a difference has been found
diffOneHelper : List a -> List a -> Bool -> Bool
diffOneHelper list1 list2 diffFound =
    case (list1, list2) of
        ([], []) ->
            -- If both lists are empty and exactly one difference has been found
            diffFound

        (x :: xs, y :: ys) ->
            if x == y then
                -- Continue recursion if elements are equal
                diffOneHelper xs ys diffFound
            else if not diffFound then
                -- If elements are different and no difference was found before, mark difference as found and continue
                diffOneHelper xs ys True
            else
                -- If elements are different and a difference was already found, return False
                False

        -- If one list is longer than the other, they cannot be identical except for one position
        (_, _) ->
            False


helper: Char -> List Char -> Int -> (Int, List Char)
helper char rest n =
    case rest of
        [] ->
            (n, rest)
        x :: xs ->
            if x == char then
                helper char xs (n+1)
            else
                (n, rest)

--
runLengthEncoding: Char -> List Char -> (String, List Char)
runLengthEncoding char list =
    let
        a = String.padLeft 4 ' ' "1"
    in
        (a, [])