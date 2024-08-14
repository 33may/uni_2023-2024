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
        (<
            (Tower t1 (disks t1 m) m)
            (Tower t2 (disks t2 m) m)
        )
        (forall ((p Int))
            (implies
                (<= 1 p 3)
                (and
                    (=
                        (Tower t1 p (+ m 1))
                        (ite
                            (= p (disks t1 m))
                            0
                            (Tower t1 p m)
                        )
                    )
                    (=
                        (Tower t2 p (+ m 1))
                        (ite
                            (= p (disks t2 (+ m 1)))
                            (Tower t1 (disks t1 m) m)
                            (Tower t2 p m)
                        )
                    )
                    (=
                        (Tower t3 p m)
                        (Tower t3 p (+ m 1))
                    )
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
))


(check-sat)
(echo "Step 0:")
(get-value(
    (Tower 1 1 0)
    (Tower 1 2 0)
    (Tower 1 3 0)
    (Tower 2 1 0)
    (Tower 2 2 0)
    (Tower 2 3 0)
    (Tower 3 1 0)
    (Tower 3 2 0)
    (Tower 3 3 0)
))
     (echo "Step 1:")
(get-value(
    (Tower 1 1 1)
    (Tower 1 2 1)
    (Tower 1 3 1)
    (Tower 2 1 1)
    (Tower 2 2 1)
    (Tower 2 3 1)
    (Tower 3 1 1)
    (Tower 3 2 1)
    (Tower 3 3 1)
))
     (echo "Step 2:")
(get-value(
    (Tower 1 1 2)
    (Tower 1 2 2)
    (Tower 1 3 2)
    (Tower 2 1 2)
    (Tower 2 2 2)
    (Tower 2 3 2)
    (Tower 3 1 2)
    (Tower 3 2 2)
    (Tower 3 3 2)
))
     (echo "Step 3:")
(get-value(
    (Tower 1 1 3)
    (Tower 1 2 3)
    (Tower 1 3 3)
    (Tower 2 1 3)
    (Tower 2 2 3)
    (Tower 2 3 3)
    (Tower 3 1 3)
    (Tower 3 2 3)
    (Tower 3 3 3)
))
     (echo "Step 4:")
(get-value(
    (Tower 1 1 4)
    (Tower 1 2 4)
    (Tower 1 3 4)
    (Tower 2 1 4)
    (Tower 2 2 4)
    (Tower 2 3 4)
    (Tower 3 1 4)
    (Tower 3 2 4)
    (Tower 3 3 4)
))
     (echo "Step 5:")
(get-value(
    (Tower 1 1 5)
    (Tower 1 2 5)
    (Tower 1 3 5)
    (Tower 2 1 5)
    (Tower 2 2 5)
    (Tower 2 3 5)
    (Tower 3 1 5)
    (Tower 3 2 5)
    (Tower 3 3 5)
))
     (echo "Step 6:")
(get-value(
    (Tower 1 1 6)
    (Tower 1 2 6)
    (Tower 1 3 6)
    (Tower 2 1 6)
    (Tower 2 2 6)
    (Tower 2 3 6)
    (Tower 3 1 6)
    (Tower 3 2 6)
    (Tower 3 3 6)
))
     (echo "Step 7:")
(get-value(
    (Tower 1 1 7)
    (Tower 1 2 7)
    (Tower 1 3 7)
    (Tower 2 1 7)
    (Tower 2 2 7)
    (Tower 2 3 7)
    (Tower 3 1 7)
    (Tower 3 2 7)
    (Tower 3 3 7)
))