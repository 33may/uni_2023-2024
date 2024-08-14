(declare-fun Tower(Int Int Int)Int)

(declare-fun disks(Int Int) Int)

;;Start State
(assert
    (and
        (=
            (disks 1 0)
            3
        )
        (=
            (disks 2 0)
            0
        )
        (=
            (disks 3 0)
            0
        )
        (=
            (Tower 1 1 0)
            3
        )
        (=
            (Tower 1 2 0)
            2
        )
        (=
            (Tower 1 3 0)
            1
        )
        (forall ((t Int) (p Int))
            (implies
                (and
                    (<= 2 t 3)
                    (<= 1 p 3)
                )
                (=
                    (Tower t p 0)
                    0
                )
            )
        )
    )
)

;;End State
(assert
    (and
        (=
            (disks 1 7)
            0
        )
        (=
            (disks 2 7)
            0
        )
        (=
            (disks 3 7)
            3
        )
        (=
            (Tower 3 1 7)
            3
        )
        (=
            (Tower 3 2 7)
            2
        )
        (=
            (Tower 3 3 7)
            1
        )
        (forall ((t Int) (p Int))
            (implies
                (and
                    (<= 1 t 2)
                    (<= 1 p 3)
                )
                (=
                    (Tower t p 7)
                    0
                )
            )
        )
    )
)

(define-fun move((t1 Int) (t2 Int) (t3 Int) (m Int)) Bool
    (and
        (=
            (disks t1 (+ m 1))
            (-
                (disks t1 m)
                1
            )
        )
        (=
            (disks t2 (+ m 1))
            (+
                (disks t2 m)
                1
            )
        )
        (=
            (disks t3 (+ m 1))
            (disks t3 m)
        )
    )
)



(declare-fun test(Int Int) Int)

(assert (forall ((i Int))
    (implies 
        (<= 0 i 6)
        (exists ((t1 Int) (t2 Int) (t3 Int))
                (and
                    (<= 1 t1 3)
                    (<= 1 t2 3)
                    (<= 1 t3 3)
                    (distinct t1 t2 t3)
                    (move t1 t2 t3 i)
                )
            )
        )
    )
)

(assert
    (forall ((t Int) (m Int))
        (implies
            (and
                (<= 1 t 3)
                (<= 0 m 6)
            )
            (<= 0 (disks t m) 3)
        )
    )
)

(assert (= (disks 3 1) 1))

(assert (= (disks 2 2) 1))

(assert (= (disks 1 3) 1))

(assert (= (disks 2 3) 2))

(assert (= (disks 1 5) 1))

(assert (= (disks 2 6) 0))

(check-sat)
(echo "Step 0:")
(get-value(
    (disks 1 0)
    (disks 2 0)
    (disks 3 0)
))
     (echo "Step 1:")
(get-value(
    (disks 1 1)
    (disks 2 1)
    (disks 3 1)
))
     (echo "Step 2:")
(get-value(
    (disks 1 2)
    (disks 2 2)
    (disks 3 2)
))
     (echo "Step 3:")
(get-value(
    (disks 1 3)
    (disks 2 3)
    (disks 3 3)
))
     (echo "Step 4:")
(get-value(
    (disks 1 4)
    (disks 2 4)
    (disks 3 4)
))
     (echo "Step 5:")
(get-value(
    (disks 1 5)
    (disks 2 5)
    (disks 3 5)
))
     (echo "Step 6:")
(get-value(
    (disks 1 6)
    (disks 2 6)
    (disks 3 6)
))
     (echo "Step 7:")
(get-value(
    (disks 1 7)
    (disks 2 7)
    (disks 3 7)
))