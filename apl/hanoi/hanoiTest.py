# First, we define the smt_output string for all steps
smt_output_steps = """
Step 0:
(((State 1 1 1 0) false)
 ((State 1 2 1 0) false)
 ((State 1 3 1 0) true))
(((State 2 1 1 0) false)
 ((State 2 2 1 0) true)
 ((State 2 3 1 0) false))
(((State 3 1 1 0) true)
 ((State 3 2 1 0) false)
 ((State 3 3 1 0) false))
(((State 1 1 2 0) false)
 ((State 1 2 2 0) false)
 ((State 1 3 2 0) false))
(((State 2 1 2 0) false)
 ((State 2 2 2 0) false)
 ((State 2 3 2 0) false))
(((State 3 1 2 0) false)
 ((State 3 2 2 0) false)
 ((State 3 3 2 0) false))
(((State 1 1 3 0) false)
 ((State 1 2 3 0) false)
 ((State 1 3 3 0) false))
(((State 2 1 3 0) false)
 ((State 2 2 3 0) false)
 ((State 2 3 3 0) false))
(((State 3 1 3 0) false)
 ((State 3 2 3 0) false)
 ((State 3 3 3 0) false))
Step 1:
(((State 1 1 1 1) false)
 ((State 1 2 1 1) false)
 ((State 1 3 1 1) false))
(((State 2 1 1 1) false)
 ((State 2 2 1 1) true)
 ((State 2 3 1 1) false))
(((State 3 1 1 1) false)
 ((State 3 2 1 1) true)
 ((State 3 3 1 1) false))
(((State 1 1 2 1) false)
 ((State 1 2 2 1) true)
 ((State 1 3 2 1) false))
(((State 2 1 2 1) false)
 ((State 2 2 2 1) false)
 ((State 2 3 2 1) false))
(((State 3 1 2 1) false)
 ((State 3 2 2 1) false)
 ((State 3 3 2 1) false))
(((State 1 1 3 1) true)
 ((State 1 2 3 1) false)
 ((State 1 3 3 1) false))
(((State 2 1 3 1) false)
 ((State 2 2 3 1) false)
 ((State 2 3 3 1) false))
(((State 3 1 3 1) false)
 ((State 3 2 3 1) false)
 ((State 3 3 3 1) false))
Step 2:
(((State 1 1 1 2) false)
 ((State 1 2 1 2) false)
 ((State 1 3 1 2) false))
(((State 2 1 1 2) false)
 ((State 2 2 1 2) true)
 ((State 2 3 1 2) false))
(((State 3 1 1 2) false)
 ((State 3 2 1 2) false)
 ((State 3 3 1 2) false))
(((State 1 1 2 2) false)
 ((State 1 2 2 2) true)
 ((State 1 3 2 2) false))
(((State 2 1 2 2) false)
 ((State 2 2 2 2) false)
 ((State 2 3 2 2) false))
(((State 3 1 2 2) false)
 ((State 3 2 2 2) true)
 ((State 3 3 2 2) false))
(((State 1 1 3 2) false)
 ((State 1 2 3 2) false)
 ((State 1 3 3 2) false))
(((State 2 1 3 2) true)
 ((State 2 2 3 2) false)
 ((State 2 3 3 2) false))
(((State 3 1 3 2) false)
 ((State 3 2 3 2) false)
 ((State 3 3 3 2) false))
Step 3:
(((State 1 1 1 3) false)
 ((State 1 2 1 3) false)
 ((State 1 3 1 3) false))
(((State 2 1 1 3) false)
 ((State 2 2 1 3) false)
 ((State 2 3 1 3) false))
(((State 3 1 1 3) false)
 ((State 3 2 1 3) false)
 ((State 3 3 1 3) false))
(((State 1 1 2 3) false)
 ((State 1 2 2 3) true)
 ((State 1 3 2 3) true))
(((State 2 1 2 3) false)
 ((State 2 2 2 3) true)
 ((State 2 3 2 3) false))
(((State 3 1 2 3) true)
 ((State 3 2 2 3) false)
 ((State 3 3 2 3) true))
(((State 1 1 3 3) false)
 ((State 1 2 3 3) false)
 ((State 1 3 3 3) false))
(((State 2 1 3 3) false)
 ((State 2 2 3 3) true)
 ((State 2 3 3 3) true))
(((State 3 1 3 3) false)
 ((State 3 2 3 3) false)
 ((State 3 3 3 3) false))
Step 4:
(((State 1 1 1 4) false)
 ((State 1 2 1 4) true)
 ((State 1 3 1 4) false))
(((State 2 1 1 4) false)
 ((State 2 2 1 4) false)
 ((State 2 3 1 4) false))
(((State 3 1 1 4) false)
 ((State 3 2 1 4) false)
 ((State 3 3 1 4) false))
(((State 1 1 2 4) true)
 ((State 1 2 2 4) true)
 ((State 1 3 2 4) false))
(((State 2 1 2 4) true)
 ((State 2 2 2 4) false)
 ((State 2 3 2 4) false))
(((State 3 1 2 4) false)
 ((State 3 2 2 4) false)
 ((State 3 3 2 4) true))
(((State 1 1 3 4) true)
 ((State 1 2 3 4) false)
 ((State 1 3 3 4) false))
(((State 2 1 3 4) false)
 ((State 2 2 3 4) false)
 ((State 2 3 3 4) false))
(((State 3 1 3 4) true)
 ((State 3 2 3 4) false)
 ((State 3 3 3 4) false))
Step 5:
(((State 1 1 1 5) true)
 ((State 1 2 1 5) false)
 ((State 1 3 1 5) true))
(((State 2 1 1 5) false)
 ((State 2 2 1 5) false)
 ((State 2 3 1 5) false))
(((State 3 1 1 5) false)
 ((State 3 2 1 5) false)
 ((State 3 3 1 5) false))
(((State 1 1 2 5) false)
 ((State 1 2 2 5) false)
 ((State 1 3 2 5) false))
(((State 2 1 2 5) false)
 ((State 2 2 2 5) false)
 ((State 2 3 2 5) true))
(((State 3 1 2 5) false)
 ((State 3 2 2 5) true)
 ((State 3 3 2 5) false))
(((State 1 1 3 5) false)
 ((State 1 2 3 5) false)
 ((State 1 3 3 5) false))
(((State 2 1 3 5) false)
 ((State 2 2 3 5) false)
 ((State 2 3 3 5) true))
(((State 3 1 3 5) false)
 ((State 3 2 3 5) false)
 ((State 3 3 3 5) false))
Step 6:
(((State 1 1 1 6) false)
 ((State 1 2 1 6) false)
 ((State 1 3 1 6) true))
(((State 2 1 1 6) false)
 ((State 2 2 1 6) false)
 ((State 2 3 1 6) false))
(((State 3 1 1 6) false)
 ((State 3 2 1 6) false)
 ((State 3 3 1 6) false))
(((State 1 1 2 6) false)
 ((State 1 2 2 6) true)
 ((State 1 3 2 6) false))
(((State 2 1 2 6) false)
 ((State 2 2 2 6) false)
 ((State 2 3 2 6) false))
(((State 3 1 2 6) false)
 ((State 3 2 2 6) false)
 ((State 3 3 2 6) false))
(((State 1 1 3 6) true)
 ((State 1 2 3 6) false)
 ((State 1 3 3 6) false))
(((State 2 1 3 6) true)
 ((State 2 2 3 6) false)
 ((State 2 3 3 6) false))
(((State 3 1 3 6) false)
 ((State 3 2 3 6) false)
 ((State 3 3 3 6) false))
Step 7:
(((State 1 1 1 7) false)
 ((State 1 2 1 7) false)
 ((State 1 3 1 7) false))
(((State 2 1 1 7) false)
 ((State 2 2 1 7) false)
 ((State 2 3 1 7) false))
(((State 3 1 1 7) false)
 ((State 3 2 1 7) false)
 ((State 3 3 1 7) false))
(((State 1 1 2 7) false)
 ((State 1 2 2 7) false)
 ((State 1 3 2 7) false))
(((State 2 1 2 7) false)
 ((State 2 2 2 7) false)
 ((State 2 3 2 7) false))
(((State 3 1 2 7) false)
 ((State 3 2 2 7) false)
 ((State 3 3 2 7) false))
(((State 1 1 3 7) false)
 ((State 1 2 3 7) false)
 ((State 1 3 3 7) true))
(((State 2 1 3 7) false)
 ((State 2 2 3 7) true)
 ((State 2 3 3 7) false))
(((State 3 1 3 7) true)
 ((State 3 2 3 7) false)
 ((State 3 3 3 7) false))
"""

# Parse the string and convert it into a readable format, showing each move
# Corrected function to parse and visualize the SMT output, showing each move and refreshing the towers after each move
def parse_and_visualize_steps_corrected(smt_output_steps):
    # Split the output into steps
    steps = smt_output_steps.strip().split('Step')
    
    # Initialize the tower state
    tower_state = {
        1: ["3", "2", "1"],  # Tower 1
        2: [" ", " ", " "],  # Tower 2
        3: [" ", " ", " "],   # Tower 3
    }
    
    # Parse each step
    for step in steps[1:]:  # Skip the first empty split
        # Split the step into lines
        lines = step.strip().split('\n')
        
        # The first line is the step number
        step_number = lines[0].strip(':')
        print(f"Step {step_number}:")
        
        # Reset the step state to avoid carrying over the previous state
        step_state = {
            1: [" ", " ", " "],  # Tower 1
            2: [" ", " ", " "],  # Tower 2
            3: [" ", " ", " "]   # Tower 3
        }
        
        # Parse each line in the step
        for line in lines[1:]:
            # Clean up the line and extract the relevant parts
            parts = line.strip("()").split()
            state_function, disk, position, tower, move, value = parts
            
            # Update the step state if the value is true
            if value == "true":
                # Note that the position is 1-indexed and needs to be converted to 0-indexed
                step_state[int(tower)][abs(3 - int(position))] = str(disk)
        
        # Update the tower state based on the step state and make the move
        for tower_num in range(1, 4):
            for position in range(3):
                tower_state[tower_num][position] = step_state[tower_num][position]
        
        # Visualize the towers after each step
        for tower_num, tower in tower_state.items():
            print(f"Tower {tower_num}: {tower[::-1]}")  # Reverse the tower for bottom to top display
        print("\n")

# Let's run the function to parse and visualize the SMT output for each step with moves
parse_and_visualize_steps_corrected(smt_output_steps)
