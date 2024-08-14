(declare-const dogs Int)
(declare-const cats Int)
(declare-const mice Int)

(assert
    (and
        (=
            (+
                (* dogs 60)
                (* cats 4)
                (* mice 1)
            )
            400
        )
        (=
            (+ dogs cats mice)
            100
        )
        (>
            dogs
            0
        )
        (>
            cats
            0
        )
        (>
            mice
            0
        )
    )
)

(check-sat)
(get-model)