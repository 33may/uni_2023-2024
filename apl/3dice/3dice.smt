(declare-fun d1 (Int) Int)
(declare-fun d2 (Int) Int)
(declare-fun d3 (Int) Int)

; Ensure that each die has distinct elements
(assert (distinct (d1 1) (d1 2) (d1 3) (d1 4)))
(assert (distinct (d2 1) (d2 2) (d2 3) (d2 4)))
(assert (distinct (d3 1) (d3 2) (d3 3) (d3 4)))

(define-fun d1Contains ((letter Int)) Bool
  (or
    (= (d1 1) letter)
    (= (d1 2) letter)
    (= (d1 3) letter)
    (= (d1 4) letter)
  )
)

(define-fun d2Contains ((letter Int)) Bool
  (or
    (= (d2 1) letter)
    (= (d2 2) letter)
    (= (d2 3) letter)
    (= (d2 4) letter)
  )
)

(define-fun d3Contains ((letter Int)) Bool
  (or
    (= (d3 1) letter)
    (= (d3 2) letter)
    (= (d3 3) letter)
    (= (d3 4) letter)
  )
)

; Function to check if a word can be formed from the dice
(define-fun can_form_word ((l1 Int) (l2 Int) (l3 Int)) Bool
  (or
    (and (d1Contains l1)
         (d2Contains l2)
         (d3Contains l3)
    )

    ; Case 2: l1 from Die 1, l2 from Die 3, l3 from Die 2
    (and (d1Contains l1)
         (d2Contains l3)
         (d3Contains l2)
    )

    ; Case 3: l1 from Die 2, l2 from Die 1, l3 from Die 3
    (and (d1Contains l2)
         (d2Contains l1)
         (d3Contains l2)
    )

    ; Case 4: l1 from Die 2, l2 from Die 3, l3 from Die 1
    (and (d1Contains l3)
         (d2Contains l1)
         (d3Contains l2)
    )

    ; Case 5: l1 from Die 3, l2 from Die 1, l3 from Die 2
    (and (d1Contains l2)
         (d2Contains l3)
         (d3Contains l1)
    )

    ; Case 6: l1 from Die 3, l2 from Die 2, l3 from Die 1
    (and (d1Contains l3)
         (d2Contains l2)
         (d3Contains l1)
    )
  )
)

; Assert that each word can be formed from the dice
(assert (can_form_word 2 1 12)) ; CAT
(assert (can_form_word 11 8 7)) ; SON
(assert (can_form_word 9 8 3))  ; POD
(assert (can_form_word 10 6 5)) ; RIG
(assert (can_form_word 9 4 5))  ; PEG
(assert (can_form_word 12 1 9)) ; TAP
(assert (can_form_word 3 6 7))  ; DIN
(assert (can_form_word 1 9 4))  ; APE

; Check for satisfiability
(check-sat)
(get-value (
  (d1 1)
  (d1 2)
  (d1 3)
  (d1 4)
  (d2 1)
  (d2 2)
  (d2 3)
  (d2 4)
  (d3 1)
  (d3 2)
  (d3 3)
  (d3 4)
))

