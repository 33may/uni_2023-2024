; Declare the state function
(declare-fun State (Int Int Int Int) Bool)

; Helper function to check if no smaller discs are not belove position p on tower t at step i
(define-fun no_smaller_discs_belove ((j Int) (p Int) (t Int) (i Int)) Bool
    (forall ((k Int) (q Int))
        (implies
            (and (< 0 k j)(< 0 q p))
            (not (State k q t i))
        )
    )
)

(define-fun number_of_disks ((t Int) (i Int)) Int
    (let ((disks_on_tower
        (+ (if (State 1 1 t i) 1 0)
           (if (State 2 1 t i) 1 0)
           (if (State 3 1 t i) 1 0)
           (if (State 1 2 t i) 1 0)
           (if (State 2 2 t i) 1 0)
           (if (State 3 2 t i) 1 0)
           (if (State 1 3 t i) 1 0)
           (if (State 2 3 t i) 1 0)
           (if (State 3 3 t i) 1 0))))
    disks_on_tower)
)

(define-fun no_discs_above ((j Int) (p Int) (t Int) (i Int)) Bool
    (forall ((k Int) (q Int))
        (implies
            (and (>= k 1) (<= k 3) (> q p) (<= q 3))
            (not (State k q t i))
        )
    )
)

; Pre-move condition using the helper function
(define-fun pre_move ((j Int) (p Int) (t Int) (i Int)) Bool
  (and
    (State j p t i)
    (no_smaller_discs_belove j p t i)
    (no_discs_above j p t i)
  )
)

; Post-move condition using the helper function
(define-fun post_move ((j Int) (p1 Int) (p2 Int) (t1 Int) (t2 Int) (i Int) ) Bool
  (and
    (and
        (not (State j p1 t1 (+ i 1)))
        (State j p2 t2 (+ i 1))
    )
    (no_smaller_discs_belove j p2 t2 (+ i 1))
    (no_discs_above j p2 t2 (+ i 1))
  )
)

; Define the move function
(define-fun do_move ((j Int) (p1 Int) (p2 Int) (t1 Int) (t2 Int) (i Int)) Bool
  (and
    (pre_move j p1 t1 i)
    (post_move j p1 p2 t1 t2 i)
    (=
        (number_of_disks t1 i)
        (+
            (number_of_disks t1 (+ i 1))
            1
        )
    )
    (=
        (number_of_disks t2 i)
        (-
            (number_of_disks t2 (+ i 1))
            1
        )
    )
  )
)

; Assert the initial state: all discs are on the first tower (tower 1) at move 0
(assert (and
  (State 1 3 1 0) ; Disk 1 (smallest) is at position 1 on tower 1 at move 0
  (State 2 2 1 0) ; Disk 2 (middle) is at position 2 on tower 1 at move 0
  (State 3 1 1 0) ; Disk 3 (largest) is at position 3 on tower 1 at move 0
  (not (State 3 2 1 0))
  (not (State 3 3 1 0))
  (not (State 2 1 1 0))
  (not (State 2 3 1 0))
  (not (State 1 2 1 0))
  (not (State 1 1 1 0))
))

; Assert that no disks are on towers 2 and 3 at move 0, for any position
(assert (forall ((disk Int) (pos Int))
  (implies
    (and (<= 1 disk 3) (<= 1 pos 3))
    (and
      (not (State disk pos 2 0)) ; Disk is not on tower 2 at move 0
      (not (State disk pos 3 0)) ; Disk is not on tower 3 at move 0
    )
  )
))


; Assert the final state: all discs are on the third tower (tower 3) at the final move (move 7)
(assert (and
  (State 1 3 3 7) ; Disk 1 (smallest) is at position 3 on tower 3 at move 7
  (State 2 2 3 7) ; Disk 2 (middle) is at position 2 on tower 3 at move 7
  (State 3 1 3 7) ; Disk 3 (largest) is at position 1 on tower 3 at move 7
  (not (State 3 2 3 7))
  (not (State 3 3 3 7))
  (not (State 2 1 3 7))
  (not (State 2 3 3 7))
  (not (State 1 2 3 7))
  (not (State 1 1 3 7))
))

; Assert that no disks are on towers 1 and 2 at the final move (move 7), for any position
(assert (forall ((disk Int) (pos Int))
  (implies
    (and (<= 1 disk 3) (<= 1 pos 3))
    (and
      (not (State disk pos 1 7)) ; Disk is not on tower 1 at move 7
      (not (State disk pos 2 7)) ; Disk is not on tower 2 at move 7
    )
  )
))


; Encode possible moves using quantifiers
(assert (forall ((i Int)) (implies (and (>= i 0) (< i 7))
  (exists ((j Int) (p1 Int) (p2 Int) (t1 Int) (t2 Int))
    (and
      (>= j 1) (<= j 3)
      (>= t1 1) (<= t1 3)
      (>= t2 1) (<= t2 3)
      (>= p1 1) (<= p1 3)
      (>= p2 1) (<= p2 3)
      (not (= t1 t2))
      (do_move j p1 p2 t1 t2 i)
    )
  )
)))



(check-sat)
; Ask the solver to find a solution
(echo "Step 0:")
(get-value ((State 1 1 1 0) (State 1 2 1 0) (State 1 3 1 0)))
(get-value ((State 2 1 1 0) (State 2 2 1 0) (State 2 3 1 0)))
(get-value ((State 3 1 1 0) (State 3 2 1 0) (State 3 3 1 0)))

(get-value ((State 1 1 2 0) (State 1 2 2 0) (State 1 3 2 0)))
(get-value ((State 2 1 2 0) (State 2 2 2 0) (State 2 3 2 0)))
(get-value ((State 3 1 2 0) (State 3 2 2 0) (State 3 3 2 0)))

(get-value ((State 1 1 3 0) (State 1 2 3 0) (State 1 3 3 0)))
(get-value ((State 2 1 3 0) (State 2 2 3 0) (State 2 3 3 0)))
(get-value ((State 3 1 3 0) (State 3 2 3 0) (State 3 3 3 0)))

(echo "Step 1:")
(get-value ((State 1 1 1 1) (State 1 2 1 1) (State 1 3 1 1)))
(get-value ((State 2 1 1 1) (State 2 2 1 1) (State 2 3 1 1)))
(get-value ((State 3 1 1 1) (State 3 2 1 1) (State 3 3 1 1)))

(get-value ((State 1 1 2 1) (State 1 2 2 1) (State 1 3 2 1)))
(get-value ((State 2 1 2 1) (State 2 2 2 1) (State 2 3 2 1)))
(get-value ((State 3 1 2 1) (State 3 2 2 1) (State 3 3 2 1)))

(get-value ((State 1 1 3 1) (State 1 2 3 1) (State 1 3 3 1)))
(get-value ((State 2 1 3 1) (State 2 2 3 1) (State 2 3 3 1)))
(get-value ((State 3 1 3 1) (State 3 2 3 1) (State 3 3 3 1)))
(echo "Step 2:")
(get-value ((State 1 1 1 2) (State 1 2 1 2) (State 1 3 1 2)))
(get-value ((State 2 1 1 2) (State 2 2 1 2) (State 2 3 1 2)))
(get-value ((State 3 1 1 2) (State 3 2 1 2) (State 3 3 1 2)))
(get-value ((State 1 1 2 2) (State 1 2 2 2) (State 1 3 2 2)))
(get-value ((State 2 1 2 2) (State 2 2 2 2) (State 2 3 2 2)))
(get-value ((State 3 1 2 2) (State 3 2 2 2) (State 3 3 2 2)))
(get-value ((State 1 1 3 2) (State 1 2 3 2) (State 1 3 3 2)))
(get-value ((State 2 1 3 2) (State 2 2 3 2) (State 2 3 3 2)))
(get-value ((State 3 1 3 2) (State 3 2 3 2) (State 3 3 3 2)))
(echo "Step 3:")
(get-value ((State 1 1 1 3) (State 1 2 1 3) (State 1 3 1 3)))
(get-value ((State 2 1 1 3) (State 2 2 1 3) (State 2 3 1 3)))
(get-value ((State 3 1 1 3) (State 3 2 1 3) (State 3 3 1 3)))
(get-value ((State 1 1 2 3) (State 1 2 2 3) (State 1 3 2 3)))
(get-value ((State 2 1 2 3) (State 2 2 2 3) (State 2 3 2 3)))
(get-value ((State 3 1 2 3) (State 3 2 2 3) (State 3 3 2 3)))
(get-value ((State 1 1 3 3) (State 1 2 3 3) (State 1 3 3 3)))
(get-value ((State 2 1 3 3) (State 2 2 3 3) (State 2 3 3 3)))
(get-value ((State 3 1 3 3) (State 3 2 3 3) (State 3 3 3 3)))
(echo "Step 4:")
(get-value ((State 1 1 1 4) (State 1 2 1 4) (State 1 3 1 4)))
(get-value ((State 2 1 1 4) (State 2 2 1 4) (State 2 3 1 4)))
(get-value ((State 3 1 1 4) (State 3 2 1 4) (State 3 3 1 4)))
(get-value ((State 1 1 2 4) (State 1 2 2 4) (State 1 3 2 4)))
(get-value ((State 2 1 2 4) (State 2 2 2 4) (State 2 3 2 4)))
(get-value ((State 3 1 2 4) (State 3 2 2 4) (State 3 3 2 4)))
(get-value ((State 1 1 3 4) (State 1 2 3 4) (State 1 3 3 4)))
(get-value ((State 2 1 3 4) (State 2 2 3 4) (State 2 3 3 4)))
(get-value ((State 3 1 3 4) (State 3 2 3 4) (State 3 3 3 4)))
(echo "Step 5:")
(get-value ((State 1 1 1 5) (State 1 2 1 5) (State 1 3 1 5)))
(get-value ((State 2 1 1 5) (State 2 2 1 5) (State 2 3 1 5)))
(get-value ((State 3 1 1 5) (State 3 2 1 5) (State 3 3 1 5)))
(get-value ((State 1 1 2 5) (State 1 2 2 5) (State 1 3 2 5)))
(get-value ((State 2 1 2 5) (State 2 2 2 5) (State 2 3 2 5)))
(get-value ((State 3 1 2 5) (State 3 2 2 5) (State 3 3 2 5)))
(get-value ((State 1 1 3 5) (State 1 2 3 5) (State 1 3 3 5)))
(get-value ((State 2 1 3 5) (State 2 2 3 5) (State 2 3 3 5)))
(get-value ((State 3 1 3 5) (State 3 2 3 5) (State 3 3 3 5)))
(echo "Step 6:")
(get-value ((State 1 1 1 6) (State 1 2 1 6) (State 1 3 1 6)))
(get-value ((State 2 1 1 6) (State 2 2 1 6) (State 2 3 1 6)))
(get-value ((State 3 1 1 6) (State 3 2 1 6) (State 3 3 1 6)))
(get-value ((State 1 1 2 6) (State 1 2 2 6) (State 1 3 2 6)))
(get-value ((State 2 1 2 6) (State 2 2 2 6) (State 2 3 2 6)))
(get-value ((State 3 1 2 6) (State 3 2 2 6) (State 3 3 2 6)))
(get-value ((State 1 1 3 6) (State 1 2 3 6) (State 1 3 3 6)))
(get-value ((State 2 1 3 6) (State 2 2 3 6) (State 2 3 3 6)))
(get-value ((State 3 1 3 6) (State 3 2 3 6) (State 3 3 3 6)))
(echo "Step 7:")
(get-value ((State 1 1 1 7) (State 1 2 1 7) (State 1 3 1 7)))
(get-value ((State 2 1 1 7) (State 2 2 1 7) (State 2 3 1 7)))
(get-value ((State 3 1 1 7) (State 3 2 1 7) (State 3 3 1 7)))
(get-value ((State 1 1 2 7) (State 1 2 2 7) (State 1 3 2 7)))
(get-value ((State 2 1 2 7) (State 2 2 2 7) (State 2 3 2 7)))
(get-value ((State 3 1 2 7) (State 3 2 2 7) (State 3 3 2 7)))
(get-value ((State 1 1 3 7) (State 1 2 3 7) (State 1 3 3 7)))
(get-value ((State 2 1 3 7) (State 2 2 3 7) (State 2 3 3 7)))
(get-value ((State 3 1 3 7) (State 3 2 3 7) (State 3 3 3 7)))