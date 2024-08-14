; Define a 4x4 grid or 5x5 grid
(define-const size Int 4)

(declare-fun grid (Int Int) Int)

(assert (forall ((j Int)) 
    (=> (and (>= j 1) (<= j size))
        (distinct 
            (grid 1 j) 
            (grid 2 j) 
            (grid 3 j) 
            (grid 4 j)
            (ite (= size 5) (grid 5 j) 0)  ; conditional for 5x5
        )
    )
))
; Assert distinct values for rows
(assert (forall ((i Int)) 
    (=> (and (>= i 1) (<= i size))
        (distinct 
            (grid i 1) 
            (grid i 2) 
            (grid i 3) 
            (grid i 4)
            (ite (= size 5) (grid i 5) 0)  ; conditional for 5x5
        )
    )
))

(assert (forall ((i Int) (j Int)) 
    (=> (and (>= i 1) (<= i size) (>= j 1) (<= j size))
        (and (>= (grid i j) 1) (<= (grid i j) size))
    )
))

(define-fun MaxTower ((x Int) (y Int)) Int
    (ite (> x y) x y)
)

(define-fun count-visible-4 ((a Int) (b Int) (c Int) (d Int)) Int
    (let ((maxA a)
          (maxB (MaxTower a b))
          (maxC (MaxTower (MaxTower a b) c)))
        (+ 
            (ite (> a 0) 1 0)
            (ite (> b maxA) 1 0)
            (ite (> c maxB) 1 0)
            (ite (> d maxC) 1 0)
        )
    )
)
(define-fun count-visible-5 ((a Int) (b Int) (c Int) (d Int) (e Int)) Int
    (let ((maxA a)
          (maxB (MaxTower a b))
          (maxC (MaxTower (MaxTower a b) c))
          (maxD (MaxTower (MaxTower (MaxTower a b) c) d)))
        (+ 
            (ite (> a 0) 1 0)
            (ite (> b maxA) 1 0)
            (ite (> c maxB) 1 0)
            (ite (> d maxC) 1 0)
            (ite (> e maxD) 1 0)
        )
    )
)
(assert 
    (=
        (count-visible-4
            (grid 4 2)
            (grid 3 2)
            (grid 2 2)
            (grid 1 2)
        )
        2
    )
)
(assert 
    (=
        (count-visible-4
            (grid 4 3)
            (grid 3 3)
            (grid 2 3)
            (grid 1 3)
        )
        2
    )
)
(assert 
    (=
        (count-visible-4
            (grid 4 4)
            (grid 3 4)
            (grid 2 4)
            (grid 1 4)
        )
        2
    )
)
(assert 
    (=
        (count-visible-4
            (grid 1 1 )
            (grid 1 2 )
            (grid 1 3 )
            (grid 1 4 )
        )
        4
    )
)
(check-sat)
(get-value (
    (grid 1 1) (grid 2 1) (grid 3 1) (grid 4 1)
    (grid 1 2) (grid 2 2) (grid 3 2) (grid 4 2)
    (grid 1 3) (grid 2 3) (grid 3 3) (grid 4 3)
    (grid 1 4) (grid 2 4) (grid 3 4) (grid 4 4)
))
