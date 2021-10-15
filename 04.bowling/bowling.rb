#!/usr/bin/env ruby
# frozen_string_literal: true

params = ARGV[0].split(',')

scores = []
params.each do |param|
  if param == 'X'
    scores << 10
    scores << 0
  else
    scores << param.to_i
  end
end

scores = scores.each_slice(2).to_a

# check last score
if scores.size == 11
  scores[-2] = scores[9..].flatten
  scores.delete_at(-1)
elsif scores.size == 12
  last_score = scores[9..]
  last_score.flatten!.delete(0)
  scores[-3] = last_score
  scores.delete_at(-1)
  scores.delete_at(-1)
end

final_scores = []

scores.each.with_index(1) do |score, i|
  sum = if i >= 1 && i <= 9
          if score[0] == 10 && i == 9
            score.sum + scores[i][0] + scores[i][1]
          elsif score[0] == 10 && i != 9
            scores[i][0] == 10 ? score.sum + scores[i][0] + scores[i + 1][0] : score.sum + scores[i][0] + scores[i][1]
          elsif score.sum == 10
            score.sum + scores[i][0]
          else
            score.sum
          end
        else
          score.sum
        end
  final_scores << sum
end

p final_scores.sum
