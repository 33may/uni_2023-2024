(declare-const c1 Int)
(declare-const c2 Int)
(declare-const c3 Int)

(assert 
  (exists ((e1 Int) (e2 Int) (e3 Int)) 
    (and (>= e1 0) (<= e1 3)
         (>= e2 0) (<= e2 3)
         (>= e3 0) (<= e3 3)
         (= (+ e1 e2 e3) 3)
         (= (+ (* e1 c1) (* e2 c2) (* e3 c3)) 20)
    )
  )
)

; For 23 centos
(assert 
  (exists ((e1 Int) (e2 Int) (e3 Int)) 
    (and (>= e1 0) (<= e1 3)
         (>= e2 0) (<= e2 3)
         (>= e3 0) (<= e3 3)
         (= (+ e1 e2 e3) 3)
         (= (+ (* e1 c1) (* e2 c2) (* e3 c3)) 23)
    )
  )
)

(assert 
  (exists ((e1 Int) (e2 Int) (e3 Int)) 
    (and (>= e1 0) (<= e1 3)
         (>= e2 0) (<= e2 3)
         (>= e3 0) (<= e3 3)
         (= (+ e1 e2 e3) 3)
         (= (+ (* e1 c1) (* e2 c2) (* e3 c3)) 29)
    )
  )
)

(assert (> c1 0))
(assert (> c2 0))
(assert (> c3 0))

(check-sat)
(get-model)
