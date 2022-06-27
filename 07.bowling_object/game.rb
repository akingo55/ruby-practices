# frozen_string_literal: true

class Game
  attr_reader :frame

  def initialize(frame)
    @frame = frame
  end

  def strike?
    @frame[0] == 10
  end

  def spare?
    @frame[0] + @frame[1] == 10 && @frame[0] != 10
  end
end
