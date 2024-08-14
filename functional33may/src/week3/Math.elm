module Math exposing (..)


type Fun
    = Plus Fun Fun
    | Mult Fun Fun
    | Poly Float Fun
    | Const Float
    | Var Char


print : Fun -> String
print f =
    case f of
        Plus f1 f2 ->
            "(" ++print f1++ " + " ++print f2++")"
        Mult f1 f2 ->
            "(" ++print f1++ " * " ++print f2++")"
        Poly n f1 ->
            print f1 ++ " ^ " ++ String.fromFloat n
        Const n ->
            String.fromFloat n
        Var c ->
            String.fromChar c


eval: Float -> Fun -> Float
eval x f =

    case f of
        Plus f1 f2 ->
            let
                l = eval x f1
                r = eval x f2
            in
            l + r
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


graph: Fun -> Float -> Float -> Float -> Float -> String
graph f xmin xmax ymin ymax =
    printLn f xmin xmax ymin ymax

printVal: Fun -> Float -> Float -> String
printVal f cur ymax =
    if cur > ymax then
        ""
    else
        if cur < eval cur f then
            "*" ++ printVal f (cur + 1) ymax
        else
            "-" ++ printVal f (cur + 1) ymax


printLn: Fun -> Float -> Float -> Float -> Float -> String
printLn f cur xmax ymin ymax=
    if cur > xmax then
        ""
   else
        printVal f ymin ymax ++ "\n"++ printLn f (cur + 1) xmax ymin ymax



--      ( 3 + 5 ) * 2
example1 : Fun
example1 =
    Mult (Plus (Var 'x') (Const 5)) (Const 2.5)

-- ((4 * 2) + ( 7 ^ 3 ))
example2 : Fun
example2 =
    Plus (Mult (Const 4) (Const 2)) (Poly 3 (Const 7))


--  ( (4 * 2) + 3 ^ 2 ) * ( 7 + x )
example3 : Fun
example3 =
    Mult (Plus (Mult (Const 4) (Const 2)) (Poly 2 (Const 3))) (Plus (Const 7) (Var 'x'))


graph1 : Fun
graph1 =
    Plus (Var 'x') (Const 1)

