# frozen_string_literal: true

class Frame
  def initialize(first_shot, second_shot = 0, third_shot = nil)
    @first_shot = first_shot
    @second_shot = second_shot
    @third_shot = third_shot
  end

  def strike?
    @first_shot == 10
  end

  def bonus_score
    if @third_shot.nil?
      strike? ? [@first_shot] : [@first_shot, @second_shot]
    else
      [@first_shot, @second_shot, @third_shot]
    end
  end

  def spare?
    @first_shot + @second_shot == 10 && !strike?
  end

  def total_score
    @third_shot = 0 if @third_shot.nil?
    @first_shot + @second_shot + @third_shot
  end
end
