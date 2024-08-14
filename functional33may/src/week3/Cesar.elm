
--------------- Week3/cesar
--------------- Anton Novokhatskiy

-- commands to test:    import Cesar exposing (..)
--                      allTests


module Cesar exposing (..)

import Char exposing (fromCode, toCode, isLower, isUpper)

-- Encodes a single character with a given offset.
encode: Int -> Char -> Char
encode offset letter =
  let
        -- Determine the base ASCII code for 'a' or 'A' depending on the case of the character.
        base = if isLower letter then toCode 'a' else toCode 'A'
        alphaLength = 26
    in
    -- Only encode alphabetical characters.
    if isLower letter || isUpper letter then
            -- Calculate the new character code with wrapping.
            -- (toCode char - base + offset) calculates the new position relative to the base.
            -- modBy alphaLength ensures the result is in matching alphabet range (lower or upper).
            -- + base shifts the character back to the correct ASCII range.
        fromCode (modBy alphaLength (toCode letter - base + offset) + base)
    else
        -- Non-alphabetical characters are unchanged.
        letter

-- Decodes a single character with a given offset.
decode: Int -> Char -> Char
decode offset letter =
  -- Decoding is simply encoding with a negative offset.
  encode (-offset) letter

-- Decodes a string with a given offset.
encrypt : Int -> String -> String
encrypt offset text =
    let
        list = String.toList text
    in
        String.fromList (encryptList offset list)

encryptList : Int -> List Char -> List Char
encryptList offset list =
    case list of
        [] ->
            []
        x :: xs ->
            encode offset x :: encryptList offset xs


decrypt: Int -> String -> String
decrypt offset text =
    encrypt -offset text

normalizeAlter : String -> String
normalizeAlter text =
    let
        list = String.toList text
    in
    String.fromList (List.filter Char.isAlpha list)


normalize : String -> String
normalize s =
    let
        list = String.toList s
    in
    String.fromList (normalizeList list)

normalizeList : List Char -> List Char
normalizeList list =
    case list of
        [] ->
            []
        x :: xs ->
           if Char.isAlpha x then
                x :: normalizeList xs
           else
                normalizeList xs

-- Generates all possible decryptions for a given text.
decryptAll : String -> List (Int, String)
decryptAll text =
    let
        keys = List.range 1 25
    in
        List.map (\key ->(key, decrypt key text)) keys

-- Checks if `sub` is a substring of `main`, starting from `start`.
isSubstring: String -> String -> Int -> Bool
isSubstring main sub start =
    let
        -- Should i separate this check in outer function and then do
        --isSubstring: String -> String -> Int -> Int(main len) -> Int(su len) -> Bool
        -- it will reduce number of calculations but makes it less readable
        fullLen = String.length main
        subLen = String.length sub
        end = start + subLen
    in
    if start + subLen > fullLen then
        False
    else
        if sub == String.slice start end main then
            True
        else
            isSubstring main sub (start + 1)

isSubstringAlter: String -> String -> Bool
isSubstringAlter main sub =
    let
        fullLen = String.length main
        subLen = String.length sub
    in
    isSubstringHelper main sub 0 fullLen subLen


isSubstringHelper: String -> String -> Int -> Int -> Int -> Bool
isSubstringHelper main sub start fullLen subLen =
    let
        end = start + subLen
    in
    if start + subLen > fullLen then
        False
    else
        if sub == String.slice start end main then
            True
        else
            isSubstring main sub (start + 1)

-- Checks if any of the `canaries` are contained in the decrypted text.
containList: (Int, String) -> List String -> Bool
containList (offset, text) canaries =
    case canaries of
        [] ->
            False
        x :: xs ->
            if isSubstringAlter text x then
                True
            else
                containList (offset, text) xs


-- Filters decrypted texts to only those containing any of the `canaries`.
forceDecrypt: String -> List String -> List (Int, String)
forceDecrypt text canaries=
    let
        decrypted = decryptAll text
    in
        List.filter (\n -> containList n canaries) decrypted


-- Test functions for encoding
testEncode1: Bool
testEncode1 = (encode 5 'x' == 'c')

testEncode2: Bool
testEncode2 = (encode 7 'T' == 'A')

testEncode3: Bool
testEncode3 = (encode 56 '&'  == '&')

--Test functions for decoding
testDecode1:Bool
testDecode1 = (decode 5 'c' == 'x')

testDecode3: Bool
testDecode3 = (decode 23 '#'  == '#')

testDecode4: Bool
testDecode4 = (decode 0 'a'  == 'a')

-- Test functions for normalize
testNormalize1: Bool
testNormalize1 = (normalize "h e l l o" == "hello")

testNormalize2: Bool
testNormalize2 = (normalize "  Elm  " == "Elm")

testNormalize4: Bool
testNormalize4 = (normalize "" == "")

testNormalizeAlter1: Bool
testNormalizeAlter1 = (normalizeAlter "Hello, World!" == "HelloWorld")

testNormalizeAlter2: Bool
testNormalizeAlter2 = (normalizeAlter "123 Elm Street!!!" == "ElmStreet")

testNormalizeAlter3: Bool
testNormalizeAlter3 = (normalizeAlter "!!!@@@" == "")


--Test functions for encrypt and decrypt
testEncrypt1: Bool
testEncrypt1 = (encrypt 5 "hello" == "mjqqt")

testEncrypt2: Bool
testEncrypt2 = (encrypt 1 "xyz" == "yza")

testDecrypt1: Bool
testDecrypt1 = (decrypt 5 "mjqqt" == "hello")

testDecrypt2: Bool
testDecrypt2 = (decrypt 1 "yza" == "xyz")

testForceDecrypt: Bool
testForceDecrypt =
    let
        encrypted = encrypt 12 "Definite article redirects here. For the comedy album, see Definite Article.A definite article is an article that marks a definite noun phrase. Definite articles, such as the English the, are used to refer to a particular member of a group. It may be something that the speaker has already mentioned, or it may be otherwise something uniquely specified.For example, Sentence 1 uses the definite article and thus, expresses a request for a particular book. In contrast, Sentence 2 uses an indefinite article and thus, conveys that the speaker would be satisfied with any book."
    in
    (forceDecrypt encrypted ["the", "and"]) == [(12,"Definite article redirects here. For the comedy album, see Definite Article.A definite article is an article that marks a definite noun phrase. Definite articles, such as the English the, are used to refer to a particular member of a group. It may be something that the speaker has already mentioned, or it may be otherwise something uniquely specified.For example, Sentence 1 uses the definite article and thus, expresses a request for a particular book. In contrast, Sentence 2 uses an indefinite article and thus, conveys that the speaker would be satisfied with any book.")]

--Tests results
allTestsEncode: List Bool
allTestsEncode = [testEncode1, testEncode2, testEncode3]

allTestsDecode: List Bool
allTestsDecode = [testDecode1, testDecode3, testDecode4]

allTestsNormalize: List Bool
allTestsNormalize = [testNormalize1, testNormalize2, testNormalize4, testNormalizeAlter1, testNormalizeAlter2, testNormalizeAlter3]

allTestsEncrypt: List Bool
allTestsEncrypt = [testEncrypt1, testEncrypt2]

allTestsDecrypt: List Bool
allTestsDecrypt = [testDecrypt1, testDecrypt2, testForceDecrypt]

allTests: List (List Bool)
allTests = [allTestsEncode, allTestsDecode, allTestsNormalize, allTestsEncrypt, allTestsDecrypt]
