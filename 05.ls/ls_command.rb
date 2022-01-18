#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

params = {}
opts = OptionParser.new
opts.on('-a') { params[:a] = true }
opts.on('-r') { params[:r] = true }
opts.on('-l') { params[:l] = true }
opts.parse!(ARGV)

def file_in_current_dir(options)
  files = Dir.glob('*')
  return files if options.empty?

  options = options.sort.to_h
  raise "ls: illegal option -- #{option}" unless %i[a r l].any? { |key| options.include?(key) }

  options.each_key do |option|
    case option
    when :a
      files = Dir.glob('*', File::FNM_DOTMATCH)
    when :r
      files = files.reverse
    end
  end
  files
end

def check_file_type(stat)
  file_types = { 'file' => '-', 'directory' => 'd', 'characterSpecial' => 'c', 'blockSpecial' => 'b',
                 'fifo' => 'p', 'link' => 'l', 'socket' => 's', 'unknown' => '?' }
  file_types[stat.ftype]
end

def converted_permission(permission_numbers)
  permission_list = { 7 => 'rwx', 6 => 'rw-', 5 => 'r-x', 4 => 'r--', 3 => '-wx', 2 => '-w-', 1 => '--x', 0 => '---' }
  permission = ''
  permission_numbers.each do |number|
    permission += permission_list[number.to_i]
  end
  permission
end

def get_file_info(files)
  outputs = []
  total_block = 0
  files.each do |file|
    stat = File.stat(file)
    total_block += stat.blocks

    splited_permission = stat.mode.to_s(8)[-3..-1].split('')
    permission = converted_permission(splited_permission)

    outputs << [
      check_file_type(stat) + permission,
      stat.nlink,
      Etc.getpwuid(stat.uid).name,
      Etc.getgrgid(stat.gid).name,
      stat.size,
      stat.mtime.strftime('%m'),
      stat.mtime.strftime('%d'),
      stat.ftype == 'file' ? stat.mtime.strftime('%H:%M') : stat.mtime.strftime('%Y'),
      file
    ]
  end

  [total_block, outputs]
end

def format_list(list, max_column)
  max_line = (list.size / max_column.to_f).ceil
  sliced_list = list.each_slice(max_line).to_a
  max_size = sliced_list.map(&:size).max
  sliced_list.map! { |x| x.values_at(0..max_size) }
  sliced_list.transpose.each { |s| puts s.join("\t") }
  sliced_list
end

def format_list_for_l_option(results)
  formatted_list = ["total #{results[0]}"]
  results[1].each do |result|
    formatted_list << result.join("\t")
  end
  puts formatted_list
end

files = file_in_current_dir(params)

if params.include?(:l)
  results = get_file_info(files)
  format_list_for_l_option(results)
else
  max_column = 3
  format_list(files, max_column)
end
