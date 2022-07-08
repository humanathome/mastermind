# frozen_string_literal: true

# computer player class
class ComputerPlayer
  def initialize; end

  def generate_color_code
    Game::PEG_COLORS.sample(4)
  end
end
