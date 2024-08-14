(declare-const city1 Int)
(declare-const city2 Int)
(declare-const city3 Int)
(declare-const city4 Int)
(declare-const city5 Int)
(declare-const city6 Int)

(define-const max Int 16)

(declare-fun distance (Int Int) Int)

(declare-const totalDistance Int)

(assert (forall ((x Int) (y Int))
    (=> (and (>= x 1) (<= x 6) (>= y 1) (<= y 6))
        (= (distance x y)
            (ite (and (= x 1) (= y 2)) 4
            (ite (and (= x 2) (= y 1)) 4
            (ite (and (= x 1) (= y 6)) 5
            (ite (and (= x 6) (= y 1)) 5
            (ite (and (= x 2) (= y 6)) 3
            (ite (and (= x 6) (= y 2)) 3
            (ite (and (= x 2) (= y 3)) 6
            (ite (and (= x 3) (= y 2)) 6
            (ite (and (= x 2) (= y 4)) 1
            (ite (and (= x 4) (= y 2)) 1
            (ite (and (= x 3) (= y 4)) 7
            (ite (and (= x 4) (= y 3)) 7
            (ite (and (= x 6) (= y 4)) 2
            (ite (and (= x 4) (= y 6)) 2
            (ite (and (= x 4) (= y 5)) 1
            (ite (and (= x 5) (= y 4)) 1
            (ite (and (= x 6) (= y 5)) 3
            (ite (and (= x 5) (= y 6)) 3
            0))))))))))))))))))
        )
    )
    )
)
(assert (<= 1 city1 6))
(assert (<= 1 city2 6))
(assert (<= 1 city3 6))
(assert (<= 1 city4 6))
(assert (<= 1 city5 6))
(assert (<= 1 city6 6))

(assert (distinct city1 city2 city3 city4 city5 city6))

(assert 
    (= 
        totalDistance 
        (+ 
            (distance city1 city2) 
            (distance city2 city3) 
            (distance city3 city4) 
            (distance city4 city5) 
            (distance city5 city6) 
        )
    )
)
(assert
    (not
        (or
            (= (distance city1 city2) 0) 
            (= (distance city2 city3) 0) 
            (= (distance city3 city4) 0) 
            (= (distance city4 city5) 0) 
            (= (distance city5 city6) 0) 
        )
    )
)
(assert
    (<=
        totalDistance
        max
    )
)
(check-sat)
(get-value(
    totalDistance
    city1
    city2
    city3
    city4
    city5
    city6
))