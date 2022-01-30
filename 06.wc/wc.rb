#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

params = {}
opts = OptionParser.new
opts.on('-l') { params[:l] = true }
opts.parse!(ARGV)

def get_file_info(files)
    return nil if files.size == 0

    ary = []
    files.each do |file|
        raise "wc: #{file}: open: No such file" unless File.file?(file)

        f = File.read(file)
        ary << [f.lines.count, f.split(' ').size, f.size, file]
    end
    return ary
end

def get_file_info_with_l(files)
    return nil if files.size == 0

    ary = []
    files.each do |file|
        raise "wc: #{file}: open: No such file" unless File.file?(file)

        f = File.read(file)
        ary << [f.lines.count, file]
    end
    return ary
end

def outputs_result(results)
    results.each do |result|
        puts results.join("\t")
    end
end

def exec_wc(params)
    results =  params[:l] ? get_file_info_with_l(ARGV) : get_file_info(ARGV)
    outputs_result(results)
end

exec_wc(params)
