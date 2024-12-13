# Tug-Of-War
The system features a "computer" player whose moves are randomized using an LFSR (Linear Feedback Shift Register) and whose difficulty increases based on the number of switches activated on the FPGA. Wins are indicated by LEDs: a computer win means the LED reachs the left most (LED 9) point of the board and a human player's win means the right most (LED 0) part of the board. After each round, the LEDs reset to the center LED. A scorecard keeps track and displays the wins for each players, and the game automatically resets once a player achieves 7 wins.
