# frozen_string_literal: true

require 'optparse'
MAX_COLUMNS = 3

class DirContents
  def initialize
    @options = {}
    OptionParser.new do |opt|
      opt.on('-a') { @options[:all] = true }
      opt.on('-r') { @options[:reverse] = true }
      opt.on('-l') { @options[:long] = true }
      opt.parse!(ARGV)
    end
  end

  def display
    if @options[:long]
      puts formated_files_with_details.unshift("total #{total_blocks}")
    else
      puts formated_files
    end
  end

  private

  def formated_files_with_details
    matched_files.map do |file|
      file_stat_details = File::Stat.new(file).details << file
      file_stat_details.join("\t")
    end
  end

  def total_blocks
    matched_files.each.sum { |file| File::Stat.new(file).blocks }
  end

  def matched_files
    files = @options[:all] ? Dir.glob('*', File::FNM_DOTMATCH).sort : Dir.glob('*').sort
    @options[:reverse] ? files.reverse : files
  end

  def max_lines
    (matched_files.size / MAX_COLUMNS.to_f).ceil
  end

  def formated_files
    files = matched_files
    splited_files = files.each_slice(max_lines).to_a
    max_size = splited_files.map(&:size).max

    splited_files.map! { |x| x.values_at(0..max_size) }

    splited_files.transpose.map { |file| file.join("\t") }
  end
end
