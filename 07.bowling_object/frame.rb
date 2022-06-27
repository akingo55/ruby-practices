# frozen_string_literal: true

class Frame
  attr_reader :scores

  def initialize(score_data)
    sliced_score_data = score_data.each_slice(2).to_a
    last_frame_scores = sliced_score_data[9..].flat_map { |s| s.grep_v(0) }
    @scores = if last_frame_scores.size == 1
                sliced_score_data[0..8] + [last_frame_scores << 0]
              else
                sliced_score_data[0..8] + [last_frame_scores]
              end
  end

  def score(order)
    @scores[order - 1]
  end
end
