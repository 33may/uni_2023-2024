def run_program(a, b):
    for i in range(1, 11):
        if a > b:
            b = 2 * b
            a = a - 3
        else:
            a = 2 * a
            b = b - 5
    return a, b

a_init = 271
b_init = 4

a_final, b_final = run_program(a_init, b_init)
print(f"Starting values: a = {a_init}, b = {b_init}")
print(f"Ending values: a = {a_final}, b = {b_final}")
