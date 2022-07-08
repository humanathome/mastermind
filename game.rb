# frozen_string_literal: true

require_relative 'player'
require_relative 'computer'
require_relative 'display'
require_relative 'input'

# main game class
class Game
  attr_accessor :white_pegs, :black_pegs, :secret_code

  include Display
  include Input

  PEG_COLORS = %w[red green blue yellow orange purple].freeze

  def initialize
    @player = HumanPlayer.new
    @computer = ComputerPlayer.new
  end

  def set_role
    role = prompt_for_role
    if role == 1
      puts "Your role: code-maker\n\n"
      @player.role = :code_maker
    else
      puts "Your role: code-breaker\n\n"
      @player.role = :code_breaker
    end
  end

  def setup_game
    display_intro_and_rules
    set_role
    @secret_code = if @player.role == :code_maker
                     prompt_for_color_code
                   else
                     @computer.generate_color_code
                   end
  end

  def reset_pegs
    @white_pegs = 0
    @black_pegs = 0
  end

  def check_guess(guess, code)
    reset_pegs
    guess.each_with_index do |peg, index|
      if code[index] == peg
        @black_pegs += 1
      elsif code.include?(peg)
        @white_pegs += 1
      end
    end
  end

  def won?(black_pegs)
    black_pegs == 4
  end

  def lost?(turn)
    turn + 1 == 12
  end

  # call this method if the player is the code-breaker
  def human_code_breaker
    12.times do |turn|
      puts "\nTurn #{turn + 1} of 12"
      guess = prompt_for_color_code
      check_guess(guess, @secret_code)
      if won?(@black_pegs)
        display_winning_message('You')
        break
      end
      display_pegs(@black_pegs, @white_pegs)
      display_losing_message('You') if lost?(turn)
    end
  end

  # call this method if the player is the code-maker
  def computer_code_breaker
    12.times do |turn|
      puts "\nTurn #{turn + 1} of 12"
      display_thinking_message
      computer_guess = @computer.generate_color_code
      display_computer_guess(computer_guess)
      check_guess(computer_guess, @secret_code)
      if won?(@black_pegs)
        display_winning_message('Computer')
        break
      end
      display_pegs(@black_pegs, @white_pegs)
      display_losing_message('Computer') if lost?(turn)
    end
  end

  def play
    setup_game
    if @player.role == :code_breaker
      human_code_breaker
    else
      computer_code_breaker
    end
    display_code(@secret_code)
  end
end
