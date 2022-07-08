# frozen_string_literal: true

# contains methods for getting and validating the player input
module Input
  def prompt_for_role
    puts 'Would you like to play as a: 1. Code-maker or 2. Code-breaker? Enter 1 or 2:'
    role = gets.chomp.to_i
    until [1, 2].include?(role)
      puts 'Please enter 1 or 2.'
      role = gets.chomp.to_i
    end
    role
  end

  def prompt_for_color_code
    puts 'Please enter a combination of 4 colors separated by one space (no repeating colors):'
    color_code = gets.chomp.downcase.split(' ')
    until colors_valid?(color_code) && color_code.length == 4 && colors_unique?(color_code)
      color_code = prompt_for_color_code
    end
    color_code
  end

  def colors_valid?(guess)
    guess.all? { |color| Game::PEG_COLORS.include?(color) }
  end

  def colors_unique?(colors)
    colors.uniq.length == colors.length
  end

  def play_again?
    puts 'Would you like to play again? (y/n)'
    answer = gets.chomp
    answer.downcase == 'y'
  end
end
