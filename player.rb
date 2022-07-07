# frozen_string_literal: true

require_relative 'display'

# human player class
class HumanPlayer
  attr_accessor :role

  include Display

  def initialize; end

  # ask player to make their code of 4 colors if they are the code-maker
  def prompt_for_color_code
    puts 'Enter your super-secret color code separated by spaces:'
    gets.chomp.split(' ')
  end

  # ask player to make their guess of 4 colors if they are the code-breaker
  def prompt_for_guess
    puts 'Enter your guess separated by spaces:'
    gets.chomp.split(' ')
  end
end
