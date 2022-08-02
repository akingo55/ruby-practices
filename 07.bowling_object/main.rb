# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

def main(marks)
  shots = Shot.prepare(marks)
  frame_shots = []
  frames = []

  shots.each do |shot|
    frame_shots << shot

    next if frames.size >= 9

    if shot.strike? && frame_shots.size != 2
      frame_shots << Shot.new(0)
      frames << Frame.new(*frame_shots)
      frame_shots = []
    elsif frame_shots.size == 2
      frames << Frame.new(*frame_shots)
      frame_shots = []
    end
  end
  frames << Frame.new(*frame_shots)
  puts game_score(frames)
end

def game_score(frames)
  frames.each.with_index.sum do |frame, index|
    next_frame = index == 9 ? nil : frames[index + 1]
    after_next_frame = index >= 8 ? nil : frames[index + 2]
    frame.total_score(next_frame, after_next_frame)
  end
end

main(ARGV[0])
