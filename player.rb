# frozen_string_literal: true

# human player class
class HumanPlayer
  attr_accessor :role

  def initialize; end

  def ask_for_role
    puts 'Would you like to play as a: 1. Code-maker or 2. Code-breaker? Enter 1 or 2:'
    role = gets.chomp.to_i
    until [1, 2].include?(role)
      puts 'Please enter 1 or 2.'
      role = gets.chomp.to_i
    end
    role
  end

  def ask_for_color_code
    puts 'Please enter a combination of 4 colors separated by one space (no repeating colors):'
    gets.chomp.downcase.split(' ')
  end

  def enter_and_validate_color_code
    color_code = ask_for_color_code
    color_code_valid?(color_code)
  end

  private

  # check if guess consists of valid colors, is 4 words long and contains unique colors
  def color_code_valid?(color_code)
    until valid_colors?(color_code) && color_code.length == 4 && colors_unique?(color_code)
      color_code = ask_for_color_code
    end
    color_code
  end

  # check if all colors are found in the list of allowed colors
  def valid_colors?(guess)
    guess.all? { |color| Game::PEG_COLORS.include?(color) }
  end

  def colors_unique?(color_code)
    color_code.uniq.length == color_code.length
  end
end
