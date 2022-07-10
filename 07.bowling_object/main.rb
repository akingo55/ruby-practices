# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

marks = ARGV[0].split(',')

def main(marks)
  shots = []
  frames = []

  marks.each do |mark|
    shot = Shot.new(mark)
    shots << shot.score

    if frames.size < 10
      if shots.size == 2 || shot.score == 10
        frames << shots.dup
        shots.clear
      end
    else
      frames.last << shot.score
    end
  end

  puts game_score(frames)
end

def game_score(frames)
  game_score = 0

  frames.each.with_index(1) do |frame, index|
    frame = Frame.new(frame)
    next_frame_score = index == 10 ? [0] : frames[index]
    after_next_frame_score = index >= 9 ? [0] : frames[index + 1]
    left_frames = next_frame_score + after_next_frame_score

    game_score += if frame.strike?
                    frame.score.sum + left_frames[0] + left_frames[1]
                  elsif frame.spare?
                    frame.score.sum + left_frames[0]
                  else
                    frame.score.sum
                  end
  end
  game_score
end

main(marks)
