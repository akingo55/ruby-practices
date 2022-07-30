# frozen_string_literal: true

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_shot, second_shot = 0, third_shot = nil)
    @first_shot = first_shot
    @second_shot = second_shot
    @third_shot = third_shot
  end

  def strike?
    @first_shot.score == 10
  end

  def strike_bonus_score(next_frame, after_next_frame)
    if next_frame.nil?
      0
    elsif next_frame.strike? && !after_next_frame.nil?
      next_frame.first_shot.score + after_next_frame.first_shot.score
    else
      next_frame.first_shot.score + next_frame.second_shot.score
    end
  end

  def spare_bonus_score(next_frame)
    next_frame.nil? ? 0 : next_frame.first_shot.score
  end

  def spare?
    @first_shot.score + @second_shot.score == 10 && !strike?
  end

  def all_shots
    if @third_shot.nil?
      [@first_shot.score, @second_shot.score]
    else
      [@first_shot.score, @second_shot.score, @third_shot.score]
    end
  end

  def total_score(next_frame, after_next_frame)
    total_frame_score = all_shots.sum

    bonus_score = if strike?
                    strike_bonus_score(next_frame, after_next_frame)
                  elsif spare?
                    spare_bonus_score(next_frame)
                  else
                    0
                  end
    total_frame_score + bonus_score
  end
end
