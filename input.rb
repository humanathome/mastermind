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

  # ask player to make their code of 4 colors if they are the code-maker
  def prompt_for_color_code
    puts 'Enter your super-secret color code separated by spaces:'
    gets.chomp.split(' ')
  end

  # ask player to make their guess of 4 colors if they are the code-breaker
  def prompt_for_guess
    puts 'Enter your guess separated by spaces:'
    guess = gets.chomp.downcase.split(' ')
    until guess_valid?(guess) && !guess.empty?
      puts 'Please enter 4 colors separated by spaces.'
      guess = gets.chomp.downcase.split(' ')
    end
    guess
  end

  def guess_valid?(guess)
    guess.all? { |color| Game::PEG_COLORS.include?(color) }
  end

  def play_again?
    puts 'Would you like to play again? (y/n)'
    answer = gets.chomp
    answer.downcase == 'y'
  end
end
