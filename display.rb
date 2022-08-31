# frozen_string_literal: true

# contains methods for displaying textual info
module Display
  def display_intro_and_rules
    puts Rainbow("\nWelcome to Mastermind!").green
    puts <<~INTRO

      Game rules:
      The game has 6 colors in total: red, green, blue, yellow, orange, purple.
      The Code-maker will generate a code which will be a combination of these colors, placed in 4 slots.
      There are no duplicate colors nor blanks in the secret code, but duplicate colors in guesses are allowed.

      The Code-breaker gets 12 turns to guess the code.
      Each turn, the code-breaker will be asked to enter a combination of 4 colors.
      For each color in correct position, a black peg is awarded.
      For each color that is included in the code, but not in the correct position, a white peg is awarded.

    INTRO
  end

  def display_computer_guess(guess)
    puts 'Computer is thinking...'
    puts "Computer's guess: #{guess.join(' - ')}"
  end

  def display_guess_feedback(black_pegs, white_pegs)
    puts Rainbow("Round result: #{black_pegs} black pegs and #{white_pegs} white pegs.").bright
  end

  def display_winning_message(winner)
    puts Rainbow("\nGame over! #{winner} WON!!!").green
  end

  def display_losing_message(loser)
    puts Rainbow("\nGame over! #{loser} LOST...").red
  end

  def display_code(code)
    puts "The code was: #{code.join(' - ').upcase}"
  end
end
