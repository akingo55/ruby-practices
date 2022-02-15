#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
params = {}
opts = OptionParser.new
opts.on('-l') { params[:l] = true }
opts.parse!(ARGV)

def exec(params)
  inputs = File.pipe?($stdin) ? [{ str: ARGF.read, filename: nil }] : ARGV.map { |file| { str: File.read(file), filename: file } }
  total_line_count = 0
  total_size = 0
  total_bytesize = 0

  inputs.each do |input|
    str = input[:str]
    filename = input[:filename]
    output = params[:l] ? [str.lines.count, filename] : [str.lines.count, str.split(' ').size, str.size, filename]
    puts output.join("\t")
    next if inputs.size <= 1

    total_line_count += str.lines.count
    total_size = str.split(' ').size
    total_bytesize = str.size
  end

  total = params[:l] ? [total_line_count, 'total'] : [total_line_count, total_size, total_bytesize, 'total']
  puts total.join("\t") if inputs.size > 1
end

exec(params)
