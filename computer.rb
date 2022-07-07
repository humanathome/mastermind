# frozen_string_literal: true

# computer player class
class ComputerPlayer
  attr_reader :secret_code

  def initialize; end

  def generate_secret_code
    @secret_code = Game::PEG_COLORS.sample(4)
  end
end
