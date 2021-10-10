#! /user/bin/ruby ruby
# frozen_string_literal: true

params = ARGV[0]
params_ary = params.split(',')

scores = []
params_ary.each do |s|
  if s == 'X'
    scores << 10
    scores << 0
  else
    scores << s.to_i
  end
end

scores = scores.each_slice(2).to_a

# check last score
if scores.size == 11 && scores[-1].size == 1
  scores[-2] << scores.last[0]
  scores.delete_at(-1)
elsif scores.size == 11 && scores[-1].size == 2
  scores[-2] << scores[-1][0]
  scores[-2] << scores[-1][1]
  scores.delete_at(-1)
elsif scores.size == 12
  scores[-3] = [10, 10, 10]
  scores.delete_at(-1)
  scores.delete_at(-1)
end

def cal_nomal_score(score)
  score.sum
end

def cal_spare_score(score, next_score)
  score.sum + next_score
end

final_scores = []
count = 1

scores.each do |score|
  sum = if count >= 1 && count <= 8
          if score[0] == 10
            scores[count][0] == 10 ? score.sum + scores[count][0] + scores[count + 1][0] : score.sum + scores[count][0] + scores[count][1]
          elsif score.sum == 10
            cal_spare_score(score, scores[count][0])
          else
            cal_nomal_score(score)
          end
        elsif count == 9
          if score[0] == 10
            score.sum + scores[count][0] + scores[count][1]
          elsif score.sum == 10
            cal_spare_score(score, scores[count][0])
          else
            cal_nomal_score(score)
          end
        else
          cal_nomal_score(score)
        end
  final_scores << sum
  count += 1
end

p final_scores.sum
