def parse_input(s):
    # Split the input by lines
    lines = s.strip().split("\n")
    if len(lines) not in [16, 25]:
        raise ValueError("Invalid input length. Expected 16 (for 4x4) or 25 (for 5x5) lines.")
    
    grid = {}

    for line in lines:
        parts = line.replace('(', '').replace(')', '').split()
        row = int(parts[1])
        col = int(parts[2])
        value = int(parts[-1])
        grid[(row, col)] = value

    size = int(len(grid)**0.5)  # Determining the size of the grid
    for i in range(1, size + 1):
        for j in range(1, size + 1):
            print(grid[(j, i)], end=' ')  # Note the switch in indices here
        print()  

# Test with 4x4 grid
data = """
(((grid 1 1) 1)
 ((grid 2 1) 2)
 ((grid 3 1) 3)
 ((grid 4 1) 4)
 ((grid 1 2) 2)
 ((grid 2 2) 3)
 ((grid 3 2) 4)
 ((grid 4 2) 1)
 ((grid 1 3) 3)
 ((grid 2 3) 4)
 ((grid 3 3) 1)
 ((grid 4 3) 2)
 ((grid 1 4) 4)
 ((grid 2 4) 1)
 ((grid 3 4) 2)
 ((grid 4 4) 3))
"""
parse_input(data)

