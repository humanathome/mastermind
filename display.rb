# frozen_string_literal: true

# contains methods for displaying textual info
module Display
  def display_intro_and_rules
    puts <<-INTRO
  Welcome to Mastermind!
  Game rules:
  The game has 6 colors in total: red, green, blue, yellow, orange, purple.
  The Code-maker will generate a code which will be a combination of these colors, placed in 4 slots.
  There are no duplicate colors nor blanks.

  The Code-breaker gets 12 turns to guess the code.
  Each turn, the code-breaker will be asked to enter a combination of 4 colors.
  For each color in correct position, a black peg is awarded.
  For each color that is included in the code, but not in the correct position, a white peg is awarded.
    INTRO
  end

  def display_guess(guess)
    puts "Your guess was: #{guess}"
  end

  def display_pegs(black_pegs, white_pegs)
    puts "You have #{black_pegs} black pegs and #{white_pegs} white pegs."
  end

  def display_winning_message
    puts 'Game over! YOU WON!!!'
  end

  def display_losing_message
    puts 'Game over! YOU LOST...'
  end

  def display_code(code)
    puts "The code was: #{code.join(' - ')}"
  end

  def play_again?
    puts 'Would you like to play again? (y/n)'
    answer = gets.chomp
    answer.downcase == 'y'
  end
end
