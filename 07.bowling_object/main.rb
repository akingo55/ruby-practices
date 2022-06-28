# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'
require_relative 'game'

params = ARGV[0].split(',')
score_data = []

params.each do |param|
  shot = Shot.new(param)
  if shot.score.instance_of?(Array)
    score_data.push(shot.score[0], shot.score[1])
  else
    score_data.push(shot.score)
  end
end

frame = Frame.new(score_data)
games = []

i = 1
while i <= 10
  score = frame.score(i)
  next_score = i == 10 ? [] : frame.score(i + 1)
  after_next_score = i >= 9 ? [] : frame.score(i + 2)

  game = Game.new(score)

  sum = if i <= 9
          if game.strike? && i == 9
            score.sum + next_score[0..1].sum
          elsif game.strike? && next_score[0] == 10
            score.sum + next_score.sum + after_next_score[0]
          elsif game.strike?
            score.sum + next_score.sum
          elsif game.spare?
            score.sum + next_score[0]
          else
            score.sum
          end
        else
          score.sum
        end
  games << sum
  i += 1
end

p games.sum
