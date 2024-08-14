; Declare an array `path` that maps integers to integers, intended to represent the sequence of points in our walking path.
(declare-const path (Array Int Int))

; Define the maximum index for our path as 17 (resulting in 18 moves given 0-based indexing).
(define-const max Int 17)

; Assert constraint to prevent walking to immediate neighbors (with a difference of 1 or 7) or staying on the same point (difference of 0).
(assert 
    (forall ((i Int))
        (=> (and (>= i 0) (< i max))
            (let ((move-diff (- (select path (+ i 1)) (select path i))))
            (not 
                (or
                    (= (abs move-diff) 1) ; Prevent moving to immediate neighbors
                    (= (abs move-diff) 7) ; Wrap-around case for a circle of 8 points
                    (= move-diff 0)       ; Prevent staying at the same point
                )
            ))
        )
    )
)

; Assert constraint to ensure that each entry of the path lies between 1 and 8 (inclusive), representing our 8 points.
(assert 
    (forall ((i Int))
        (=> (and (>= i 0) (<= i max))
            (and
                (<= (select path i) 8)
                (>= (select path i) 1)
            )
        )
    )
)

; Assert constraint to ensure that the same move or its reverse is not repeated in the path.
(assert 
    (forall ((i Int))
        (=> (and (>= i 0) (< i max))
            (forall ((x Int))
                (=> (and (>= x 0) (< x max) (not (= x i)))
                    (let ((a (select path i)) (b (select path (+ i 1)))
                          (c (select path x)) (d (select path (+ x 1))))
                    (not (or 
                        (and (= a d) (= b c)) ; Prevent repeating reverse moves
                        (and (= a c) (= b d)) ; Prevent repeating the same move
                    ))))
            )
        )
    )
)


(check-sat)


    (echo "Move[1]:")  (eval (select path 0)) (echo "-") (eval (select path 1))
    (echo "Move[2]:")  (eval (select path 1)) (echo "-") (eval (select path 2))
    (echo "Move[3]:")  (eval (select path 2)) (echo "-") (eval (select path 3))
    (echo "Move[4]:")  (eval (select path 3)) (echo "-") (eval (select path 4))
    (echo "Move[5]:")  (eval (select path 4)) (echo "-") (eval (select path 5))
    (echo "Move[6]:")  (eval (select path 5)) (echo "-") (eval (select path 6))
    (echo "Move[7]:")  (eval (select path 6)) (echo "-") (eval (select path 7))
    (echo "Move[8]:")  (eval (select path 7)) (echo "-") (eval (select path 8))
    (echo "Move[9]:")  (eval (select path 8)) (echo "-") (eval (select path 9))
    (echo "Move[10]:") (eval (select path 9)) (echo "-") (eval (select path 10))
    (echo "Move[11]:") (eval (select path 10)) (echo "-") (eval (select path 11))
    (echo "Move[12]:") (eval (select path 11)) (echo "-") (eval (select path 12))
    (echo "Move[13]:") (eval (select path 12)) (echo "-") (eval (select path 13))
    (echo "Move[14]:") (eval (select path 13)) (echo "-") (eval (select path 14))
    (echo "Move[15]:") (eval (select path 14)) (echo "-") (eval (select path 15))
    (echo "Move[16]:") (eval (select path 15)) (echo "-") (eval (select path 16))
    (echo "Move[17]:") (eval (select path 16)) (echo "-") (eval (select path 17))
    (echo "Move[18]:") (eval (select path 17)) (echo "-") (eval (select path 18))
    (echo "Move[19]:") (eval (select path 18)) (echo "-") (eval (select path 19))
    (echo "Move[20]:") (eval (select path 19)) (echo "-") (eval (select path 20))