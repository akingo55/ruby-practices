# frozen_string_literal: true

class Frame
  def initialize(scores)
    @scores = scores
  end

  def strike?
    @scores[0] == 10
  end

  def spare?
    @scores[0..1].sum == 10 && !strike?
  end

  def total_score
    @scores.sum
  end
end
