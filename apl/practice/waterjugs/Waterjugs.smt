(declare-fun maxJug(Int) Int)

(declare-fun q (Int Int) Int)

(declare-const N Int)

(define-fun pour ((j1 Int) (j2 Int) (j3 Int) (t Int)) Bool
    (and
        (distinct
            (q j1 t)
            (q j1 (+ t 1))
        )
		(distinct
            (q j2 t)
            (q j2 (+ t 1))
        )
		(= 
            (q j3 t)
            (q j3 (+ t 1))
        )
	    (or
			(= (q j1 (+ 1 t)) 0)
    		(= (q j2 (+ 1 t)) (maxJug j2))
	    )
    )
)

(assert (= (maxJug 1) 8))
(assert (= (maxJug 2) 5))
(assert (= (maxJug 3) 3))

(assert (= (q 1 0) 8))
(assert (= (q 2 0) 0))
(assert (= (q 3 0) 0))

(assert (= (q 1 N) 4))
(assert (= (q 2 N) 4))
(assert (= (q 3 N) 0))

(assert 
    (forall ((t Int))
        (=> (>= t 0)
            (= 8 (+ (q 1 t) (q 2 t) (q 3 t)))
        )
    )
)

(assert 
    (forall ((t Int))
        (=> (>= t 0)
            (and
                (>= (q 1 t) 0)
                (>= (q 2 t) 0 ) 
                (>= (q 3 t) 0 )
                
                (<= (q 1 t) (maxJug 1))
                (<= (q 2 t) (maxJug 2) ) 
                (<= (q 3 t) (maxJug 3))
            )
        )
    )
)

(assert
    (forall ((t Int))
	(implies 
		(<= 0 t N)
		(exists ((j1 Int) (j2 Int) (j3 Int))
			(and
				(distinct j1 j2 j3)
                
				(<= 1 j1 3)
				(<= 1 j2 3)
				(<= 1 j3 3)

				(pour j1 j2 j3 t)
			)
		)
	)
    ) 
)
(assert
    (<= 0 N 7)
)
(check-sat)
(get-value (

  (q 1 0)
  (q 2 0)
  (q 3 0)

  (q 1 1)
  (q 2 1)
  (q 3 1)

  (q 1 2)
  (q 2 2)
  (q 3 2)

  (q 1 3)
  (q 2 3)
  (q 3 3)

  (q 1 4)
  (q 2 4)
  (q 3 4)

  (q 1 5)
  (q 2 5)
  (q 3 5)

  (q 1 6)
  (q 2 6)
  (q 3 6)

  (q 1 7)
  (q 2 7)
  (q 3 7)
))