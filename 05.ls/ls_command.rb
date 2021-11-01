#!/usr/bin/env ruby
# frozen_string_literal: true

# obtain the path of current directory
current_dir = Dir.pwd

# カレントディレクトリを開けて'.'から始まらないもののみ取得
def get_files_and_dirs(current_dir)
  list = []
  Dir.open(current_dir).each_child do |f|
    list << f unless f.start_with?('.')
  end
  list.sort
end

def format_list(list, max_row)
  max_line = (list.size / max_row.to_f).ceil
  sliced_list = list.each_slice(max_line).to_a
  max_size = sliced_list.map(&:size).max
  sliced_list.map! { |x| x.values_at(0..max_size) }
  sliced_list.transpose.each { |s| puts s.join("\t") }
  sliced_list
end

# 複数行に分けて標準出力する
def output_list(list)
  max_row = 3
  divided_list = list.each_slice(max_row).to_a

  if list.size <= max_row
    puts list.join("\t")
  elsif divided_list[0].size == divided_list[-1].size || divided_list[0].size / 2.to_f <= divided_list[-1].size
    format_list(list, max_row)
  else
    count = max_row
    while count >= 1
      count -= 1
      divided_list = list.each_slice(count).to_a
      next unless divided_list[0].size == divided_list[-1].size || divided_list[0].size / 2.to_f <= divided_list[-1].size

      format_list(list, max_row)
      break
    end
  end
end

list = get_files_and_dirs(current_dir)
output_list(list)
