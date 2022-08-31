# frozen_string_literal: true

# computer player class
class ComputerPlayer
  def initialize
    @current_guess = []
    @potential_color_code = []
    @last_color = nil
    @possible_permutations = []
    @game_colors = %w[red green blue yellow orange purple]
  end

  def generate_color_code
    @game_colors.sample(4)
  end

  def make_guess
    if potential_color_code_full?
      make_permutations(@potential_color_code)
      @possible_permutations.pop
    else
      pick_next_two_colors
    end
  end

  # find out which colors are in the secret code and which one of them is the last color
  def act_on_guess_feedback(white_pegs, black_pegs)
    return if potential_color_code_full?

    unless @last_color
      check_for_last_color(white_pegs, black_pegs)
      puts Rainbow('LAST COLOR FOUND!').cyan + " Computer thinks the last color is #{@last_color}." if @last_color
    end
    act_on_pegs_amount(white_pegs, black_pegs)
  end

  private

  # find out which colors appear in the secret code and save them to the @potential_color_code array
  def act_on_pegs_amount(white_pegs, black_pegs)
    case white_pegs + black_pegs
    when 1
      save_color(@current_guess.last)
    when 3
      save_color(@current_guess.first)
    when 4
      save_color(@current_guess.uniq)
    end
  end

  def save_color(colors)
    @potential_color_code.push(*colors)
  end

  def pick_next_two_colors
    @current_guess = [@game_colors.shift] * 3 + [@game_colors.shift]
  end

  def check_for_last_color(white_pegs, black_pegs)
    if black_pegs.zero? && [3, 4].include?(white_pegs)
      @last_color = @current_guess.first
    elsif black_pegs == 1 && white_pegs.zero? || black_pegs == 2 && white_pegs == 2
      @last_color = @current_guess.last
    end
  end

  def potential_color_code_full?
    @potential_color_code.length == 4
  end

  def make_permutations(colors)
    return unless @possible_permutations.empty?

    colors_without_last_color = colors - [@last_color]
    puts Rainbow('Found all the colors, generating permutations now...').cyan
    @possible_permutations = colors_without_last_color.permutation(3).to_a.each { |combo| combo << @last_color }
  end
end
