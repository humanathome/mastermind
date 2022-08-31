# frozen_string_literal: true

require_relative 'player'
require_relative 'computer'
require_relative 'display'
require 'rainbow'

# main game class
class Game
  include Display

  PEG_COLORS = %w[red green blue yellow orange purple].freeze

  def initialize
    @white_pegs = 0
    @black_pegs = 0
    @code_breaker = ''
    @human = HumanPlayer.new
    @computer = ComputerPlayer.new
    @secret_code = []
    @round = 0
  end

  def play
    setup_game
    @code_breaker == 'Human' ? human_code_breaker : computer_code_breaker
    display_final_result
    display_code(@secret_code)
    play_again? ? Game.new.play : exit
  end

  private

  def setup_game
    display_intro_and_rules
    set_role
    make_secret_code
  end

  def set_role
    role = @human.ask_for_role
    if role == 1
      puts "Your role: #{Rainbow("code-maker\n").green}"
      @code_breaker = 'Computer'
    else
      puts "Your role: #{Rainbow("code-breaker\n").green}"
      @code_breaker = 'Human'
    end
  end

  def make_secret_code
    if @code_breaker == 'Human'
      @secret_code = @computer.generate_color_code
    else
      @secret_code = @human.enter_and_validate_secret_code until @secret_code.uniq.length == 4
    end
  end

  def human_code_breaker
    until @round == 12
      increment_and_display_round
      check_guess(@human.enter_and_validate_secret_code)
      break if won?

      display_guess_feedback(@black_pegs, @white_pegs)
    end
  end

  def computer_code_breaker
    until @round == 12
      increment_and_display_round

      computer_guess = @computer.make_guess
      display_computer_guess(computer_guess)
      check_guess(computer_guess)
      display_guess_feedback(@black_pegs, @white_pegs)
      break if won?

      @computer.act_on_guess_feedback(@white_pegs, @black_pegs)
    end
  end

  def increment_and_display_round
    @round += 1
    puts Rainbow("\n--- Round #{@round} ---").green
  end

  def reset_pegs
    @white_pegs = 0
    @black_pegs = 0
  end

  def check_guess(guess)
    reset_pegs
    guess.each_with_index do |color, index|
      if @secret_code[index] == color
        @black_pegs += 1
      elsif @secret_code.include?(color)
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

  def display_final_result
    display_winning_message(@code_breaker) if won?
    display_losing_message(@code_breaker) if lost?
  end

  def play_again?
    puts Rainbow("\nWould you like to play again? (y/n)").yellow
    answer = gets.chomp
    answer.downcase == 'y'
  end
end
