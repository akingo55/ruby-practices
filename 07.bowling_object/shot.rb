# frozen_string_literal: true

class Shot
  attr_reader :shot

  def initialize(shot)
    @shot = shot == 'X' ? 10 : shot.to_i
  end

  def self.prepare(marks)
    shots = marks.split(',')
    shots.map { |shot| Shot.new(shot).shot }
  end
end
