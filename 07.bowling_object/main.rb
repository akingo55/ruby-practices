# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

def main(marks)
  shots = Shot.prepare(marks)
  frame_score = [] # a frame score
  all_scores_per_frame = [] # all scores per each frame

  shots.each do |shot|
    frame_score << shot

    if all_scores_per_frame.size < 10
      if frame_score.size == 2 || shot == 10
        all_scores_per_frame << frame_score.dup
        frame_score = []
      end
    else
      all_scores_per_frame.last << shot
    end
  end
  puts game_score(all_scores_per_frame)
end

def game_score(scores)
  scores.each.with_index(1).sum do |score, index|
    frame = Frame.new(score)
    next_frame = index == 10 ? [0] : scores[index]
    after_next_frame = index >= 9 ? [0] : scores[index + 1]
    left_frames = next_frame + after_next_frame

    if frame.strike?
      frame.total_score + left_frames[0..1].sum
    elsif frame.spare?
      frame.total_score + left_frames[0]
    else
      frame.total_score
    end
  end
end

main(ARGV[0])
