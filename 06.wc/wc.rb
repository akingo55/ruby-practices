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

  if params[:l]
    files.each do |file|
      raise "wc: #{file}: open: No such file" unless File.file?(file)

      f = File.read(file)
      ary << [f.lines.count, file]
    end
  else
    files.each do |file|
      raise "wc: #{file}: open: No such file" unless File.file?(file)

      f = File.read(file)
      ary << [f.lines.count, f.split(' ').size, f.size, file]
    end
  end
  outputs_result(ary)
end

def outputs_result(results)
  results.each do |result|
    puts result.join("\t")
  end
end

def exec_wc(params)
  File.pipe?($stdin) ? get_info_from_standard_input(params) : get_file_info(ARGV, params)
end

def get_info_from_standard_input(params)
  str = ARGF.readlines

  if params[:l]
    puts str.size
  else
    puts [str.size, str.size, str.join('').bytesize].join("\t")
  end
end

exec_wc(params)
