# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

def main(marks)
  shots = Shot.prepare(marks)
  shots_in_frame = []
  frames = []

  shots.each do |shot|
    shots_in_frame << shot.score

    next unless frames.size < 9

    if shots_in_frame.size == 2 || shot.score == 10
      frames << Frame.new(*shots_in_frame)
      shots_in_frame = []
    end
  end
  frames << Frame.new(*shots_in_frame)
  puts game_score(frames)
end

def game_score(frames)
  frames.each.with_index(1).sum do |frame, index|
    next_frame_bonus_score = index == 10 ? [0] : frames[index].bonus_score
    after_next_frame_bonus_score = index >= 9 ? [0] : frames[index + 1].bonus_score
    left_bonus_scores = next_frame_bonus_score + after_next_frame_bonus_score

    if frame.strike?
      frame.total_score + left_bonus_scores[0..1].sum
    elsif frame.spare?
      frame.total_score + left_bonus_scores[0]
    else
      frame.total_score
    end
  end
end

main(ARGV[0])
