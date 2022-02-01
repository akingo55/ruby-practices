#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

params = {}
opts = OptionParser.new
opts.on('-l') { params[:l] = true }
opts.parse!(ARGV)

def get_file_info(files)
  raise 'wc: No arguments' if files.empty?

  ary = []
  total_line_count = 0
  total_size = 0
  total_bytesize = 0

  files.each do |file|
    raise "wc: #{file}: open: No such file" unless File.file?(file)

    f = File.read(file)
    ary << [f.lines.count, f.split(' ').size, f.size, file]
    next unless files.size > 1

    total_line_count += f.lines.count
    total_size = f.split(' ').size
    total_bytesize = f.size
  end
  ary.push([total_line_count, total_size, total_bytesize, 'total']) if files.size > 1
  outputs_result(ary)
end

def get_file_info_with_l_option(files)
  raise 'wc: No arguments' if files.empty?

  ary = []
  total_line_count = 0
  files.each do |file|
    raise "wc: #{file}: open: No such file" unless File.file?(file)

    f = File.read(file)
    ary << [f.lines.count, file]
    next unless files.size > 1

    total_line_count += f.lines.count
  end
  ary.push([total_line_count, 'total']) if files.size > 1
  outputs_result(ary)
end

def outputs_result(results)
  results.each do |result|
    puts result.join("\t")
  end
end

def exec_wc(params)
  if File.pipe?($stdin)
    get_info_from_standard_input(params)
  elsif params[:l]
    get_file_info_with_l_option(ARGV)
  else
    get_file_info(ARGV)
  end
end

def get_info_from_standard_input(params)
  str = ARGF.readlines

  if params[:l]
    puts str.size
  else
    puts [str.size, str.join(' ').split(' ').size, str.join('').bytesize].join("\t")
  end
end

exec_wc(params)
