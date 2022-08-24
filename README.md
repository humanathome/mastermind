## The Odin Project: Mastermind
[Mastermind](https://en.wikipedia.org/wiki/Mastermind_(board_game)) is a game where you have to guess your opponent’s 
secret code within a certain number of turns (like hangman with colored pegs).

### Assignment
- Build a Mastermind game from the command line where you have 12 turns to guess the secret code, assuming the computer 
randomly selects the secret colors and the human player must guess them
- Refactor your code to allow the human player to choose whether they want to be the creator of the secret code or 
the guesser
- You may choose to implement a computer strategy that follows the rules of the game or you can modify these 
rules. If you choose to modify the rules, you can provide the computer additional information about each guess.

### Final Result

#### Rules

- Game has six colors to choose from: red, green, blue, yellow, orange and purple
- Secret code consists of 4 unique colors
- Duplicate color entries are allowed only in guesses
- Player can choose to be the code-maker or the code-breaker
- Code-breaker has 12 turns to guess the code-maker's secret code
- For each color in the right place, a black peg is displayed. For each color that is in the code, but in the wrong 
place, a white peg is displayed. No pegs are displayed if the color is not in the code.


#### Player

- Player's input is validated to allow only valid colors, separated by a space
- Each turn, player's input is checked against the computer's secret code and feedback is provided in the form of black 
and white pegs

#### Computer

- Based on the player's role, the computer will either generate a secret code or try to guess the player's secret code
- When guessing the player's secret code, computer makes decisions based on the number of black and white pegs, with no
cheating or any other hints provided
- In max 3 turns, computer will know what colors are in the secret code, and which one is the last color
- When all colors included in the secret code are found and the last color is known, computer will generate permutations 
whose last color is the same as the value of `@last_color` and play them as a guess one by one (max 6 additional turns)
