def parse_and_print_dice_data_v2(data):
    int_to_letter = {
        1: 'A', 2: 'C', 3: 'D', 4: 'E', 5: 'G', 6: 'I', 7: 'N', 8: 'O', 9: 'P', 10: 'R', 11: 'S', 12: 'T'
    }

    dice_sides = {}

    lines = data.strip('()\n ').split('\n')
    for line in lines:
        parts = line.strip('() ').split()
        
        # Check if it's the old or new format
        if parts[0].startswith('d'):
            die_number = parts[0][1]  # Old format (e.g., '1')
            side_number = parts[1][0]  # Old format (e.g., '1')
        elif parts[0].startswith('dice'):
            die_number = parts[1]  # New format (e.g., '1')
            side_number = parts[2]  # New format (e.g., '1')
        else:
            continue  # Skip lines that do not match either format
        
        value = int(parts[-1])  # corresponding integer value
        key = f'd{die_number}s{side_number}'  # Construct the key (e.g., 'd1s1')
        dice_sides[key] = int_to_letter.get(value, 'X')
        
    dice_configuration = {
        'Die 1': [dice_sides.get(f'd1s{i}', 'X') for i in range(1, 5)],
        'Die 2': [dice_sides.get(f'd2s{i}', 'X') for i in range(1, 5)],
        'Die 3': [dice_sides.get(f'd3s{i}', 'X') for i in range(1, 5)]
    }

    # Print the dice configuration
    for die, sides in dice_configuration.items():
        print(f"{die}: {' '.join(sides)}")

# Test with both formats
data_input_ver1 = """
(((d1 1) 10)
 ((d1 2) 9)
 ((d1 3) 7)
 ((d1 4) 2)
 ((d2 1) 6)
 ((d2 2) 12)
 ((d2 3) 4)
 ((d2 4) 8)
 ((d3 1) 3)
 ((d3 2) 1)
 ((d3 3) 11)
 ((d3 4) 5))
"""

data_input_ver2 = """
(((dice 1 1) 8)
 ((dice 1 2) 12)
 ((dice 1 3) 6)
 ((dice 1 4) 4)
 ((dice 2 1) 7)
 ((dice 2 2) 9)
 ((dice 2 3) 2)
 ((dice 2 4) 10)
 ((dice 3 1) 1)
 ((dice 3 2) 11)
 ((dice 3 3) 3)
 ((dice 3 4) 5))
"""


parse_and_print_dice_data_v2(data_input_ver1)
