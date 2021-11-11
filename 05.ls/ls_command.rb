#!/usr/bin/env ruby
# frozen_string_literal: true

# カレントディレクトリを開けて'.'から始まらないもののみ取得
def file_in_current_dir
  list = Dir.glob('*')
  list.sort
end

def format_list(list, max_column)
  max_line = (list.size / max_column.to_f).ceil
  sliced_list = list.each_slice(max_line).to_a
  max_size = sliced_list.map(&:size).max
  sliced_list.map! { |x| x.values_at(0..max_size) }
  sliced_list.transpose.each { |s| puts s.join("\t") }
  sliced_list
end

# 複数行に分けて標準出力する
def output_list(list)
  max_column = 3
  count = max_column

  while count >= 1
    divided_list = list.each_slice(count).to_a
    if divided_list[0].size == divided_list[-1].size || divided_list[0].size / 2.to_f <= divided_list[-1].size
      format_list(list, count)
      break
    end
    count -= 1
  end
end

files = file_in_current_dir
output_list(files)
