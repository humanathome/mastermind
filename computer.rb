# frozen_string_literal: true

# computer player class
class ComputerPlayer
  def initialize
    @current_guess = []
    @potential_color_code = []
    @last_color = nil
    @possible_combinations = []
    @game_colors = %w[red green blue yellow orange purple]
  end

  def generate_color_code
    @game_colors.sample(4)
  end

  def make_guess
    if potential_color_code_full? && @last_color
      make_possible_combinations(@potential_color_code)
      @possible_combinations.shift
    else
      pick_next_two_colors
    end
  end

  # main method for making decisions based on the number of pegs, the value of @last_color,
  # and the length of @potential_color_code array
  def act_on_guess_feedback(white_pegs, black_pegs)
    return if potential_color_code_full? && @last_color

    check_for_last_color(white_pegs, black_pegs)
    act_on_pegs_amount(white_pegs, black_pegs)
  end

  private

  # save colors based on the number of black and white pegs
  def act_on_pegs_amount(white_pegs, black_pegs)
    case white_pegs + black_pegs
    when 1
      save_color(@current_guess.last)
    when 3
      save_color(@current_guess.first)
    when 4
      save_color(@current_guess.uniq)
    end
    delete_colors_from_game_colors
  end

  # save color in potential_color_code array
  def save_color(color)
    @potential_color_code << color
    @potential_color_code = @potential_color_code.flatten
  end

  def pick_next_two_colors
    @current_guess = [@game_colors[0]] * 3
    @current_guess << @game_colors[1]
    @current_guess
  end

  # last color in the secret code can be found in four ways based on the number of white and black pegs
  def check_for_last_color(white_pegs, black_pegs)
    if black_pegs.zero? && [3, 4].include?(white_pegs)
      @last_color = @current_guess.first
    elsif black_pegs == 1 && white_pegs.zero? || black_pegs == 2 && white_pegs == 2
      @last_color = @current_guess.last
    end
    puts "LAST COLOR FOUND! Computer thinks the last color is #{@last_color}." if @last_color
  end

  def delete_colors_from_game_colors
    @game_colors.delete(@current_guess.first)
    @game_colors.delete(@current_guess.last)
  end

  def potential_color_code_full?
    @potential_color_code.length == 4
  end

  # make unique permutations of 4 colors included in the secret code
  def make_possible_combinations(colors)
    return unless @possible_combinations.empty?

    colors_without_last_color = colors - [@last_color]
    puts 'Generating permutations...'
    @possible_combinations = colors_without_last_color.permutation(3).to_a.each { |combo| combo << @last_color }
  end
end
