data = """
(((q 1 0) 8)
 ((q 2 0) 0)
 ((q 3 0) 0)
 ((q 1 1) 3)
 ((q 2 1) 5)
 ((q 3 1) 0)
 ((q 1 2) 3)
 ((q 2 2) 2)
 ((q 3 2) 3)
 ((q 1 3) 6)
 ((q 2 3) 2)
 ((q 3 3) 0)
 ((q 1 4) 6)
 ((q 2 4) 0)
 ((q 3 4) 2)
 ((q 1 5) 1)
 ((q 2 5) 5)
 ((q 3 5) 2)
 ((q 1 6) 1)
 ((q 2 6) 4)
 ((q 3 6) 3)
 ((q 1 7) 4)
 ((q 2 7) 4)
 ((q 3 7) 0))
"""

import re

def process_data(data):
    # Extract relevant data using regex
    matches = re.findall(r'\(q (\d) (\d)\) (\d)', data)
    
    # Convert matches to a dict for easier processing
    data_dict = {(int(match[0]), int(match[1])): int(match[2]) for match in matches}

    # Compute the actions based on the change in jug contents
    unique_times = sorted(set([key[1] for key in data_dict.keys()]))
    for i in range(1, len(unique_times)):
        current_time = unique_times[i]
        prev_time = unique_times[i-1]
        
        changes = []
        for jug in [1, 2, 3]:
            diff = data_dict[(jug, current_time)] - data_dict[(jug, prev_time)]
            if diff > 0:  # if this jug received water
                changes.append((jug, diff))
            elif diff < 0:  # if this jug gave water
                changes.append((jug, diff))

        # Determine pour action
        source_jug = [change[0] for change in changes if change[1] < 0][0]
        target_jug = [change[0] for change in changes if change[1] > 0][0]
        amount_poured = abs(changes[0][1])

        # Get the state of each jug
        state_jug1 = data_dict[(1, current_time)]
        state_jug2 = data_dict[(2, current_time)]
        state_jug3 = data_dict[(3, current_time)]

        print(f"Time {prev_time} to {current_time}: Jug {source_jug} poured {amount_poured} units to Jug {target_jug}. State: Jug1={state_jug1}, Jug2={state_jug2}, Jug3={state_jug3}")

        # If the final state is reached, stop
        if (state_jug1, state_jug2, state_jug3) == (4, 4, 0):
            break

process_data(data)