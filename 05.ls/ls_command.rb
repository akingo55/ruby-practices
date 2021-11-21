#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

params = {}
opts = OptionParser.new
opts.on('-a') { params[:a] = true }
opts.parse!(ARGV)

def file_in_current_dir(option_a)
  list = if option_a
           Dir.glob('*', File::FNM_DOTMATCH)
         else
           Dir.glob('*')
         end
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
files = file_in_current_dir(params[:a])
format_list(files, max_column)
