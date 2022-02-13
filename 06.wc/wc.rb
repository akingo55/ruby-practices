#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

params = {}
opts = OptionParser.new
opts.on('-l') { params[:l] = true }
opts.parse!(ARGV)

def get_file_info(files, params)
  raise 'wc: No arguments' if files.empty?

  ary = []
  total_line_count = 0
  total_size = 0
  total_bytesize = 0

  files.each do |file|
    raise "wc: #{file}: open: No such file" unless File.file?(file)

    f = File.read(file)
    data = params[:l] ? [f.lines.count, file] : [f.lines.count, f.split(' ').size, f.size, file]
    ary << data
    next if files.size <= 1

    total_line_count += f.lines.count
    total_size = f.split(' ').size
    total_bytesize = f.size
  end

  total = params[:l] ? [total_line_count, 'total'] : [total_line_count, total_size, total_bytesize, 'total']
  ary.push(total) if files.size > 1
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
  else
    get_file_info(ARGV, params)
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
