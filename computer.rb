# frozen_string_literal: true

# computer player class
class ComputerPlayer
  def initialize
    @current_guess = []
    @potential_color_code = []
    @rejected_colors = []
    @next_color = 0
    @last_color = nil
    @possible_combinations = []
    @game_colors = %w[red green blue yellow orange purple]
  end

  def generate_color_code
    @game_colors.sample(4)
  end

  def make_guess
    check_if_2_colors_left
    if potential_color_code_full? && @last_color.nil?
      search_for_last_color
    elsif potential_color_code_full? && @last_color
      make_possible_combinations(@potential_color_code)
      @possible_combinations.shift
    else
      pick_next_two_colors
    end
  end

  # main method for making decisions based on the number of pegs, the value of @last_color,
  # and the length of @potential_color_code and @game_colors arrays
  def act_on_guess_feedback(white_pegs, black_pegs)
    return if potential_color_code_full? && @last_color

    check_for_last_color(white_pegs, black_pegs)
    return if @game_colors.empty?

    act_on_pegs_amount(white_pegs, black_pegs)
    return unless @game_colors.length == 2 && potential_color_code_full?

    @rejected_colors += @game_colors
    @game_colors.clear
  end

  private

  # save, reject and delete colors based on the number of black and white pegs
  def act_on_pegs_amount(white_pegs, black_pegs)
    case white_pegs + black_pegs
    when 0
      reject_color(@current_guess.uniq)
    when 1
      reject_color(@current_guess.first)
      save_color(@current_guess.last)
    when 3
      reject_color(@current_guess.last)
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

  def reject_color(color)
    @rejected_colors << color
    @rejected_colors = @rejected_colors.flatten
  end

  def pick_next_two_colors
    @current_guess = [@game_colors[0]] * 3
    @current_guess << @game_colors[1]
    @current_guess
  end

  # to find out the last color, make a guess that consists of 3x rejected color + 1 color included in the secret code
  def search_for_last_color
    puts 'Trying to figure out the last color, hold on...'
    @current_guess = [@rejected_colors[0]] * 3
    @current_guess << @potential_color_code[@next_color]
    @next_color += 1
    @current_guess
  end

  # last color in the secret code can be found in three ways based on the number of white and black pegs
  def check_for_last_color(white_pegs, black_pegs)
    if black_pegs == 2 && white_pegs == 2 || black_pegs == 1 && white_pegs.zero?
      @last_color = @current_guess.last
      puts "LAST COLOR FOUND! Computer thinks the last color is: #{@last_color}."
    elsif black_pegs.zero? && white_pegs == 3
      @last_color = @current_guess.first
      puts "LAST COLOR FOUND! Computer thinks the last color is: #{@last_color}."
    end
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

  # make unique permutations of 4 colors included in the secret code
  def make_possible_combinations(colors)
    return unless @possible_combinations.empty?

    colors_without_last_color = colors - [@last_color]
    puts 'Generating permutations...'
    @possible_combinations = colors_without_last_color.permutation(3).to_a.each { |combo| combo << @last_color }
  end
end
