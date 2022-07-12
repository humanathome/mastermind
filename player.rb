# frozen_string_literal: true

require_relative 'input'

# human player class
class HumanPlayer
  attr_accessor :role

  include Input

  def initialize; end

  def make_guess
    prompt_for_color_code
  end
end
