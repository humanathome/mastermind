# frozen_string_literal: true

require_relative 'input'

# human player class
class HumanPlayer
  attr_accessor :role

  include Input

  def initialize; end

  def player_turn
    prompt_for_color_code
  end
end
