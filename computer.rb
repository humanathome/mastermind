# frozen_string_literal: true

# computer player class
class ComputerPlayer
  attr_accessor :current_guess, :potential_color_code, :next_color, :possible_combinations

  def initialize
    @potential_color_code = []
    @next_color = 0
    @possible_combinations = []
  end

  def generate_color_code
    Game::PEG_COLORS.sample(4)
  end

  def make_guess
    if potential_color_code_full?
      make_permutations
      possible_combinations.sample
    else
      pick_next_color
    end
  end

  # save color in potential_color_code array
  def save_color
    @potential_color_code.push(@current_guess[0].to_s)
  end

  def pick_next_color
    @current_guess = Game::PEG_COLORS[@next_color, 1] * 4
    @next_color += 1
    @current_guess
  end

  def potential_color_code_full?
    @potential_color_code.length == 4
  end

  # make all possible permutations from the colors included in the secret color code
  def make_permutations
    mix_colors(@potential_color_code).each do |guess|
      @possible_combinations << guess
    end
  end

  private

  # unique permutations of 4 colors
  def mix_colors(colors)
    colors.permutation(4).to_a
  end
end
