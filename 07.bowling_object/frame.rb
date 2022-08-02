# frozen_string_literal: true

class Frame
  attr_reader :shots

  def initialize(first_shot, second_shot, third_shot = nil)
    @shots = [first_shot, second_shot, third_shot].compact
  end

  def total_score(next_frame, after_next_frame)
    total_frame_score = @shots.sum(&:score)

    bonus_score = if strike?
                    strike_bonus_score(next_frame, after_next_frame)
                  elsif spare?
                    spare_bonus_score(next_frame)
                  else
                    0
                  end
    total_frame_score + bonus_score
  end

  def strike?
    @shots[0].strike?
  end

  private

  def strike_bonus_score(next_frame, after_next_frame)
    if next_frame.nil?
      0
    elsif next_frame.strike? && !after_next_frame.nil?
      next_frame.shots[0].score + after_next_frame.shots[0].score
    else
      next_frame.shots[0..1].sum(&:score)
    end
  end

  def spare_bonus_score(next_frame)
    next_frame.nil? ? 0 : next_frame.shots[0].score
  end

  def spare?
    @shots[0..1].sum(&:score) == 10 && !strike?
  end
end
