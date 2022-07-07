# frozen_string_literal: true

require_relative 'player'
require_relative 'computer'
require_relative 'display'

# main game class
class Game
  attr_accessor :white_pegs, :black_pegs

  include Display

  PEG_COLORS = %w[red green blue yellow orange purple].freeze

  def initialize
    @player = HumanPlayer.new
    @computer = ComputerPlayer.new
  end

  def prompt_for_role
    puts 'Would you like to play as a: 1. Code-maker or 2. Code-breaker? Enter 1 or 2:'
    role = gets.chomp.to_i
    until [1, 2].include?(role)
      puts 'Please enter 1 or 2.'
      role = gets.chomp.to_i
    end
    role
  end

  def set_role
    role = prompt_for_role
    if role == 1
      puts 'Your role: code-maker'
      @player.role = :code_maker
    else
      puts 'Your role: code-breaker'
      @player.role = :code_breaker
    end
  end

  def setup_game
    display_intro_and_rules
    set_role
    @computer.generate_secret_code
  end

  def reset_pegs
    @white_pegs = 0
    @black_pegs = 0
  end

  def check_guess(guess, code)
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

  def play
    setup_game
    12.times do |turn|
      reset_pegs
      puts "Turn #{turn + 1} of 12"
      guess = @player.prompt_for_guess
      check_guess(guess, @computer.secret_code)
      display_pegs(@black_pegs, @white_pegs)
      if won?(@black_pegs)
        display_winning_message
        break
      end
    end
    display_code(@computer.secret_code)
  end
end

