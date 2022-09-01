## The Odin Project: Mastermind
This project is a part of The Odin Project's Ruby curriculum. 
Project link: [Mastermind](https://www.theodinproject.com/lessons/ruby-mastermind)

### Description
Command line game where the code-breaker has to guess the code-maker's secret code which is made up of 4 unique colors.
The code-breaker receives a feedback after each guess in the form of black and white pegs.   
A black peg means that one of the colors is correct and in the 
correct position. A white peg means that one of the colors is correct but in the wrong position.  
The code-breaker has to guess the code in 12 tries or less.

### Features
- Human player can choose to be the code-maker or the code-breaker
- Based on the human player's role, the computer will either generate a secret code or try to guess the player's secret 
code
- Duplicate color entries are allowed only in guesses
- For both human and computer player, the only feedback that is given after each guess is the number of black and white
pegs
- In max 3 turns, the computer will know what colors are in the secret code, and which one is the last color
- When the computer finds all the colors in the secret code, it will generate permutations that end up with the value
of `@last_color` and play them as a guess one by one (max 6 additional turns)
- Upon winning or losing, the human player can choose to play again or exit the game

### Built with
- ruby 3.0.0 (managed by `asdf` in [.tool-versions](.tool-versions))
- [rainbow gem](https://github.com/sickill/rainbow)

### Run online
[![Run on Repl.it](https://repl.it/badge/github/humanathome/mastermind)](https://repl.it/@humanathome/mastermind)

### Run locally

Prerequisites: ruby >= 3.0.0
- clone the repository
```
git clone git@github.com:humanathome/mastermind.git
```
- cd into the cloned repository
```
cd mastermind
```
- install gems in the Gemfile
```
bundle install
```
- run
```
ruby main.rb
```

