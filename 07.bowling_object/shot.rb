# frozen_string_literal: true

class Shot
  attr_reader :score

  def initialize(score)
    @score = score == 'X' ? 10 : score.to_i
  end

  def strike?
    @score == 10
  end

  def self.prepare(marks)
    marks.split(',').map { |mark| Shot.new(mark) }
  end
end
