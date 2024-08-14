(declare-const w1 Int)
(declare-const w2 Int)
(declare-const w3 Int)
(declare-const w4 Int)

(assert (and (<= w1 w2) (<= w2 w3) (<= w3 w4)))

(assert (> w1 0))

(assert
    (forall ((i Int))
        (implies 
		    (<= 1 i 40)
		    (exists ((d1 Int) (d2 Int) (d3 Int) (d4 Int))
			    (and
				    (or (= d1 -1) (= d1 0) (= d1 1))
                    (or (= d2 -1) (= d2 0) (= d2 1))
                    (or (= d3 -1) (= d3 0) (= d3 1))
                    (or (= d4 -1) (= d4 0) (= d4 1))

                    (=
                        (+ (* d1 w1) (* d2 w2) (* d3 w3) (* d4 w4) i)
                        0
                    )
				
			    )
		    )
	    )
    )
)

(check-sat)
(get-value(
    w1
    w2
    w3
    w4
))