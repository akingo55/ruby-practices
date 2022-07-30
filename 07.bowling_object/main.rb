# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

def main(marks)
  shots = Shot.prepare(marks)
  frame_scores = []
  frames = []

  shots.each do |shot|
    frame_scores << shot

    next if frames.size >= 9

    if shot.strike? && frame_scores.size != 2
      frame_scores << Shot.new(0)
      frames << Frame.new(*frame_scores)
      frame_scores = []
    elsif frame_scores.size == 2
      frames << Frame.new(*frame_scores)
      frame_scores = []
    end
  end
  frames << Frame.new(*frame_scores)
  puts game_score(frames)
end

def game_score(frames)
  frames.each.with_index(1).sum do |frame, index|
    next_frame = index == 10 ? nil : frames[index]
    after_next_frame = index >= 9 ? nil : frames[index + 1]
    frame.total_score(next_frame, after_next_frame)
  end
end

main(ARGV[0])
