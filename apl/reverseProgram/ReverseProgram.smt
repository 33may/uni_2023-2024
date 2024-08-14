(declare-const a0 Int)
(declare-const b0 Int)

(declare-const a1 Int)
(declare-const b1 Int)

(declare-const a2 Int)
(declare-const b2 Int)

(declare-const a3 Int)
(declare-const b3 Int)

(declare-const a4 Int)
(declare-const b4 Int)

(declare-const a5 Int)
(declare-const b5 Int)

(declare-const a6 Int)
(declare-const b6 Int)

(declare-const a7 Int)
(declare-const b7 Int)

(declare-const a8 Int)
(declare-const b8 Int)

(declare-const a9 Int)
(declare-const b9 Int)

(declare-const a10 Int)
(declare-const b10 Int)


(define-fun updateVals ((a_current Int) (b_current Int) (a_next Int) (b_next Int)) Bool
    (ite (> a_current b_current)
        (and (= b_next (* 2 b_current))
             (= a_next (- a_current 3)))
        (and (= a_next (* 2 a_current))
             (= b_next (- b_current 5)))
    )
)


(assert (updateVals a0 b0 a1 b1))
(assert (updateVals a1 b1 a2 b2))
(assert (updateVals a2 b2 a3 b3))
(assert (updateVals a3 b3 a4 b4))
(assert (updateVals a4 b4 a5 b5))
(assert (updateVals a5 b5 a6 b6))
(assert (updateVals a6 b6 a7 b7))
(assert (updateVals a7 b7 a8 b8))
(assert (updateVals a8 b8 a9 b9))
(assert (updateVals a9 b9 a10 b10))

(assert (= a10 1000))
(assert (= b10 999))

(check-sat)
(get-value (a0 b0))