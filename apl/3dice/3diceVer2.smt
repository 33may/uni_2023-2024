(declare-fun dice (Int Int) Int)

(define-fun inDice((d Int) (letter Int)) Bool
    (or
        (=
            (dice d 1)
            letter
        )
        (=
            (dice d 2)
            letter
        )
        (=
            (dice d 3)
            letter
        )
        (=
            (dice d 4)
            letter
        )
    )
)

(define-fun can_form_word ((l1 Int) (l2 Int) (l3 Int)) Bool
    (exists ((d1 Int) (d2 Int) (d3 Int))
        (and
			(distinct d1 d2 d3)
                
			(<= 1 d1 3)
			(<= 1 d2 3)
			(<= 1 d3 3)

            (inDice d1 l1)

            (inDice d2 l2)
            
            (inDice d3 l3)
        )

    )
)


(assert (can_form_word 2 1 12)) ; CAT
(assert (can_form_word 11 8 7)) ; SON
(assert (can_form_word 9 8 3))  ; POD
(assert (can_form_word 10 6 5)) ; RIG
(assert (can_form_word 9 4 5))  ; PEG
(assert (can_form_word 12 1 9)) ; TAP
(assert (can_form_word 3 6 7))  ; DIN
(assert (can_form_word 1 9 4))  ; APE

(check-sat)
(get-value(
    (dice 1 1)
    (dice 1 2)
    (dice 1 3)
    (dice 1 4)

    (dice 2 1)
    (dice 2 2)
    (dice 2 3)
    (dice 2 4)

    (dice 3 1)
    (dice 3 2)
    (dice 3 3)
    (dice 3 4)
))