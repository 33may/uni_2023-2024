module Math2 exposing (..)

import Html

epsilon : Float
epsilon = 0.05

-- Function to check for approximate equality between two numbers.
isAround : Float -> Float -> Bool
isAround a b = abs ( a - b ) < epsilon



--      ( 3 + 5 ) * 2.5
example1 : Fun
example1 =
    Mult (Minus (Var 'x') (Const 5)) (Const 2.5)

-- ((4 * 2) + ( 7 ^ 3 ))
example2 : Fun
example2 =
    Plus (Mult (Const 4) (Const 2)) (Poly 3 (Const 7))


--  ((4 * 2) + 3 ^ 2) * (7 + x)
example3 : Fun
example3 =
    Mult (Plus (Mult (Const 4) (Const 2)) (Poly 2 (Const 3))) (Plus (Const 7) (Var 'x'))


graph1 : Fun
graph1 =
    Plus (Var 'x') (Const 1)

--      (((3+x)*(x-(x^5)))+2)
exampleFunction : Fun
exampleFunction =
    Plus
        (Mult
            (Plus
                (Const 3)
                (Var 'x'))
            (Minus
                (Var 'x')
                (Poly 5
                    (Var 'x')
                 )
            ))
        (Const 2)




exampleFunction3 : Fun
exampleFunction3 =
    Plus
        (Plus
            (Plus
                (Plus
                    (Poly 4 (Var 'x'))
                    (Mult (Const (-4)) (Poly 3 (Var 'x')))
                )
                (Mult (Const 6) (Poly 2 (Var 'x')))
            )
            (Mult (Const (-4)) (Var 'x'))
        )
        (Const -3)


exampleFunction4 : Fun
exampleFunction4 =
    Plus
        (Mult
            (Plus (Const 3) (Var 'x'))
            (Minus (Var 'x') (Poly 5 (Var 'x')))
        )
        (Const 2)


exampleFunction5 : Fun
exampleFunction5 =
    Plus (Var 'x') (Const 5.0)

exampleFunction6 : Fun
exampleFunction6 =
    Mult (Var 'x') (Const 10.0)


exampleFunction2 : Fun
exampleFunction2 =
    Mult
        (Plus
            (Poly 2 (Plus (Mult (Const 2) (Var 'x')) (Const 3)))
            (Mult
                (Const (-1))
                (Poly 3 (Plus (Var 'x') (Const (-1))))
            )
        )
        (Const (1/20))

-- Function to generate a graphical representation of a Fun as a string. INT
graphInt: Fun -> Int -> Int -> Int -> Int -> String
graphInt f xmin xmax ymin ymax =
    printLnInt f xmin xmax ymin ymax

printValInt: Fun -> Int -> Int -> Int -> String
printValInt f cury curx ymax =
    if cury > ymax then
        ""
    else if isAround (toFloat curx) 0 then
        "-" ++ printValInt f (cury + 1) curx ymax
    else if isAround (toFloat cury) 0 then
        "|" ++ printValInt f (cury + 1) curx ymax
    else
        if toFloat cury < eval (toFloat curx) f then
            "*" ++ printValInt f (cury + 1) curx ymax
        else
            "." ++ printValInt f (cury + 1) curx ymax


printLnInt: Fun -> Int -> Int -> Int -> Int -> String
printLnInt f cur xmax ymin ymax =
    if cur > xmax then
        ""
   else
        printValInt f ymin cur ymax ++ "\n"++ printLnInt f (cur + 1) xmax ymin ymax




-- Definition of the data type for representing mathematical functions.
type Fun
    = Plus Fun Fun
    | Minus Fun Fun
    | Mult Fun Fun
    | Poly Float Fun
    | Const Float
    | Var Char

-- Function to convert Fun to its string representation.
print : Fun -> String
print f =
    case f of
        Plus f1 f2 ->
            "(" ++print f1++ " + " ++print f2++")"
        Minus f1 f2 ->
            "(" ++ print f1 ++ " - " ++ print f2 ++ ")"
        Mult f1 f2 ->
            "(" ++print f1++ " * " ++print f2++")"
        Poly n f1 ->
            print f1 ++ " ^ " ++ String.fromFloat n
        Const n ->
            String.fromFloat n
        Var c ->
            String.fromChar c

-- Function to evaluate a Fun expression given a value for x.
eval: Float -> Fun -> Float
eval x f =

    case f of
        Plus f1 f2 ->
            let
                l = eval x f1
                r = eval x f2
            in
            l + r
        Minus f1 f2 ->
            let
                l = eval x f1
                r = eval x f2
            in
            l - r
        Mult f1 f2 ->
            let
               l = eval x f1
               r = eval x f2
            in
               l * r
        Poly n f1 ->
            let
               l = eval x f1
            in
               l ^ n
        Const n ->
            n
        Var c ->
            x

-- Function to generate a graphical representation of a Fun as a string.
graph: Fun -> Float -> Float -> Float -> Float -> String
graph f xmin xmax ymin ymax =
    printLn f xmin xmax ymin ymax

printVal: Fun -> Float -> Float -> Float -> String
printVal f cury curx ymax =
    if cury > ymax then
        ""
    else if isAround curx 0 then
        "-" ++ printVal f (cury + 0.1) curx ymax
    else if isAround cury 0 then
        "|" ++ printVal f (cury + 0.1) curx ymax
    else
        if cury < eval curx f then
            "*" ++ printVal f (cury + 0.1) curx ymax
        else
            "." ++ printVal f (cury + 0.1) curx ymax


printLn: Fun -> Float -> Float -> Float -> Float -> String
printLn f cur xmax ymin ymax =
    if cur > xmax then
        ""
   else
        printVal f ymin cur ymax ++ "\n"++ printLn f (cur + 0.1) xmax ymin ymax




exampleTestPoly: Fun
exampleTestPoly =
    (Plus
                    (Var 'x')
                    (Poly 5
                        (Mult
                            (Const -1)
                            (Var 'x')
                        )
                     )
                )

derivate: Fun -> Fun
derivate f =
    case f of
            Plus f1 f2 ->
                let
                    l = derivate f1
                    r = derivate f2
                in
                Plus l r
            Minus f1 f2 ->
                let
                    l = derivate f1
                    r = derivate f2
                in
                    Minus l r
            Mult f1 f2 ->
                case (f1, f2) of
                    (Var x, Const b) ->
                            (Const b )
                    (Const b , Var x) ->
                            (Const b )
                    _ ->
                        let
                            l = derivate f1
                            r = derivate f2
                        in
                            Plus (Mult (l) (f2)) (Mult (r) (f1))
            Poly n f1 ->
                let
                   l = derivate f1
                in
                    Mult (Mult (Const n) (Poly (n - 1) f1)) l
            Const n ->
                Const 0
            Var c ->
                Const 1

simplify: Fun -> Fun
simplify f =
    case f of
        Plus f1 f2 ->
            case (simplify f1, simplify f2) of
                (Const x, Const b) ->
                        Const (x + b)
                (Const x, s2 ) ->
                    if x == 0 then
                        s2
                    else
                        Plus (Const x) (s2)
                (s1, Const x ) ->
                    if x == 0 then
                        s1
                    else
                        Plus (s1) (Const x)
                (s1, s2) -> Plus s1 s2
        Minus f1 f2 ->
            case (simplify f1, simplify f2) of
                (Const x, Const b) ->
                        Const (x - b)
                (Const x, s2 ) ->
                    if x == 0 then
                        Mult (Const -1) s2
                    else
                        Minus (Const x) (s2)
                (s1, Const x ) ->
                    if x == 0 then
                        s1
                    else
                        Minus (s1) (Const x)
                (s1, s2) -> Minus s1 s2
        Mult f1 f2 ->
            case (simplify f1, simplify f2) of
                (Const x, Const b) ->
                    if x == 0 || b == 0 then
                        Const 0
                    else
                        Const ( x * b )
                (Const x, s2 ) ->
                    if x == 1 then
                        s2
                    else if x == 0 then
                        Const 0
                    else
                        Mult (Const x) (s2)
                (s1, Const x ) ->
                    if x == 1 then
                        s1
                    else if x == 0 then
                        Const 0
                    else
                        Mult (s1) (Const x)
                (s1, s2) -> Mult s1 s2
        Poly n f1 ->
                    case simplify f1 of
                        Const b -> Const (b ^ n)
                        s -> Poly n s

        Const n -> f
        Var n -> f


testPrint1 : Bool
testPrint1 = print example1 == "((x - 5) * 2.5)"

testPrint2 : Bool
testPrint2 = print example2 == "((4 * 2) + 7 ^ 3)"

testPrint3 : Bool
testPrint3 = print example3 == "(((4 * 2) + 3 ^ 2) * (7 + x))"

testPrint4 : Bool
testPrint4 = print graph1 == "(x + 1)"

testPrint5 : Bool
testPrint5 = print exampleFunction == "(((3 + x) * (x - x ^ 5)) + 2)"

testEval1: Bool
testEval1 = eval -1 example1 == -15

testEval2: Bool
testEval2 = eval -5 example3 == 34

testEval3: Bool
testEval3 = eval 0 exampleFunction == 2

testEval4: Bool
testEval4 = eval 2 exampleFunction == -148

testPrint: Bool
testPrint =
    print exampleFunction4 == "(((3 + x) * (x - x ^ 5)) + 2)"

testDerivate: Bool
testDerivate =
    (print <| derivate exampleFunction4) == "((((0 + 1) * (x - x ^ 5)) + ((1 - ((5 * x ^ 4) * 1)) * (3 + x))) + 0)"

testSimplify: Bool
testSimplify =
     (print <| simplify <|  derivate exampleFunction4) =="((x - x ^ 5) + ((1 - (5 * x ^ 4)) * (3 + x)))"

testDerivate1 : Bool
testDerivate1 =
    (print <| derivate exampleFunction5) == "(1 + 0)"

testSimplify1 : Bool
testSimplify1 =
    (print <| simplify <| derivate exampleFunction5) == "1"

testDerivate2 : Bool
testDerivate2 =
    (print <| derivate exampleFunction6) == "10"

testSimplify2 : Bool
testSimplify2 =
    (print <| simplify <| derivate exampleFunction6) == "10"



allTestsPrint : List Bool
allTestsPrint = [ testPrint1, testPrint2, testPrint3, testPrint4, testPrint5, testEval1, testEval2, testEval3, testEval4,testPrint, testDerivate, testSimplify, testDerivate1, testSimplify1, testDerivate2 , testSimplify2 ]

allValidTestsPassed : Bool
allValidTestsPassed = List.all identity allTestsPrint

expression : Fun
expression =
    Minus
        (Mult
            (Poly
                (3)
                (Mult
                    (Var 'x')
                    (Const 2)
                )
            )
            (Const (1/50))
        )
        (Plus
            (Var 'x')
            (Const 3)
        )



main =
    --Html.pre [] [ Html.text (graph graph1 -3 3 -4 4) ]

    --Html.pre [] [ Html.text (graph ( derivate graph1) -3 3 -4 4) ]

    --Html.pre [] [ Html.text (graph (derivate exampleFunction) -6 6 -8 8) ]

     Html.pre [] [ Html.text (graph (exampleFunction) -6 6 -8 8) ]

    --Html.pre [] [ Html.text (graph (derivate expression) -10 10 -10 8) ]

    --Html.pre [] [ Html.text (graphInt (expression) -15 15 -15 14) ]

    --Html.pre [] [ Html.text (graph exampleFunction3 -4 4 -4 4) ]

