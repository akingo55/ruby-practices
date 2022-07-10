# frozen_string_literal: true

class Frame
  attr_reader :score

  def initialize(score)
    @score = score
  end

  def strike?
    @score[0] == 10
  end

  def spare?
    @score[0] + @score[1] == 10 && @score[0] != 10
  end
end
