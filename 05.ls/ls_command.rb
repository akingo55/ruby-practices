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

max_column = 3
files = file_in_current_dir
format_list(files, max_column)
