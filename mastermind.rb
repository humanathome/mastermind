# frozen_string_literal: true

puts <<~INTRO

  Welcome to Mastermind!
  Game rules:
  The game has 6 colors in total: red, green, blue, yellow, orange, purple.
  The Code-maker will generate a code which will be a combination of these colors, placed in 4 slots.
  There are no duplicate colors nor blanks.
  You have 12 turns to guess the code.
  Each turn, you will be asked to enter a combination of 4 colors, to try and guess the colors placed in 4 slots.
  For each color in correct position, you will get a black peg.
  For each color that is in the code, but not in the correct position, you will get a white peg.

INTRO

PEG_COLORS = %w[red green blue yellow orange purple].freeze

code = PEG_COLORS.sample(4)

12.times do |turn|
  puts "Turn #{turn + 1} of 12"
  puts 'Enter your guess separated by spaces:'
  guess = gets.chomp.split(' ')
  puts "You guessed: #{guess}"

  black_pegs = 0
  white_pegs = 0

  guess.each_with_index do |peg, index|
    if code[index] == peg
      black_pegs += 1
    elsif code.include?(peg)
      white_pegs += 1
    end
  end

  if black_pegs == 4
    puts 'YOU WIN!!!'
    break
  end

  puts "You have #{black_pegs} black pegs and #{white_pegs} white pegs.\n"
end
