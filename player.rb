# frozen_string_literal: true

# human player class
class HumanPlayer
  def initialize; end

  def ask_for_role
    puts Rainbow('Would you like to play as a: 1. Code-maker or 2. Code-breaker? Enter 1 or 2:').yellow
    role = gets.chomp.to_i
    until [1, 2].include?(role)
      puts Rainbow('Please enter 1 or 2.').red
      role = gets.chomp.to_i
    end
    role
  end

  def enter_and_validate_secret_code
    color_code = ask_for_color_code
    color_code_valid?(color_code)
  end

  private

  def ask_for_color_code
    puts Rainbow('Please enter a combination of 4 colors separated by one space:').yellow
    gets.chomp.downcase.split(' ')
  end

  def color_code_valid?(color_code)
    color_code = ask_for_color_code until valid_colors?(color_code) && color_code.length == 4
    color_code
  end

  def valid_colors?(guess)
    guess.all? { |color| Game::PEG_COLORS.include?(color) }
  end
end
