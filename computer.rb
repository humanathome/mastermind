# frozen_string_literal: true

# computer player class
class ComputerPlayer
  attr_accessor :current_guess, :potential_color_code, :next_color, :possible_combinations

  def initialize
    @potential_color_code = []
    @next_color = 0
    @possible_combinations = []
    @game_colors = %w[red green blue yellow orange purple]
  end

  def generate_color_code
    @game_colors.sample(4)
  end

  def make_guess
    check_if_2_colors_left
    if potential_color_code_full?
      make_permutations
      possible_combinations.sample
    else
      pick_next_color
    end
  end

  # save and/or delete colors based on the number of black and white pegs
  def act_on_guess_feedback(white_pegs, black_pegs)
    return if potential_color_code_full?

    case white_pegs + black_pegs
    when 3
      save_color
      delete_colors_from_game_colors
    when 0
      delete_colors_from_game_colors
    when 4
      save_color
      @potential_color_code << @current_guess.last
      delete_colors_from_game_colors
    when 1
      @potential_color_code << @current_guess.last
      @game_colors.delete(@current_guess.last)
    end
  end

  private

  # save color in potential_color_code array
  def save_color
    @potential_color_code.push(@current_guess.first)
  end

  def pick_next_color
    @current_guess = @game_colors[@next_color, 1] * 3
    @current_guess << @game_colors[@next_color + 1]
    @current_guess
  end

  def delete_colors_from_game_colors
    @game_colors.delete(@current_guess.first)
    @game_colors.delete(@current_guess.last)
  end

  def check_if_2_colors_left
    return unless @game_colors.length == 2 && @potential_color_code.length == 2

    @potential_color_code += @game_colors
    @game_colors.clear
  end

  def potential_color_code_full?
    @potential_color_code.length == 4
  end

  # unique permutations of 4 colors
  def mix_colors(colors)
    colors.permutation(4).to_a
  end

  # make all possible permutations from the colors included in the secret color code
  def make_permutations
    return unless @possible_combinations.empty?

    mix_colors(@potential_color_code).each do |guess|
      @possible_combinations << guess
    end
  end
end
