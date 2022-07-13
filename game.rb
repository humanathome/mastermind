# frozen_string_literal: true

require_relative 'player'
require_relative 'computer'
require_relative 'display'

# main game class
class Game
  attr_accessor :white_pegs, :black_pegs, :code_breaker, :secret_code, :round

  include Display

  PEG_COLORS = %w[red green blue yellow orange purple].freeze

  def initialize
    @human = HumanPlayer.new
    @computer = ComputerPlayer.new
    @round = 0
  end

  def set_role
    role = @human.ask_for_role
    if role == 1
      puts "Your role: code-maker\n\n"
      @code_breaker = 'Computer'
    else
      puts "Your role: code-breaker\n\n"
      @code_breaker = 'You'
    end
  end

  def setup_game
    display_intro_and_rules
    set_role
    @secret_code = if @code_breaker == 'You'
                     @computer.generate_color_code
                   else
                     @human.enter_and_validate_color_code
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

  def won?
    @black_pegs == 4
  end

  def lost?
    @round == 12 && @black_pegs != 4
  end

  def increment_and_display_round
    @round += 1
    puts "--- Round #{@round} ---"
  end

  # call this method if the player is the code-breaker
  def human_code_breaker
    until @round == 12
      increment_and_display_round
      check_guess(@human.enter_and_validate_color_code, @secret_code)
      break if won?

      display_pegs(@black_pegs, @white_pegs)
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
      break if won?

      display_pegs(@black_pegs, @white_pegs)
    end
  end

  def play_again?
    puts 'Would you like to play again? (y/n)'
    answer = gets.chomp
    answer.downcase == 'y'
  end

  def play
    setup_game
    if @code_breaker == 'You'
      human_code_breaker
    else
      computer_code_breaker
    end
    display_winning_message(@code_breaker) if won?
    display_losing_message(@code_breaker) if lost?
    display_code(@secret_code)
    play_again? ? play : exit
  end
end
