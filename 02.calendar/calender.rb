#!/usr/bin/env ruby
require 'date'
require 'optparse'

def check_day(day)
  num = day.wday
  return num
end

def check_number(date)
  if date < 10
    date = sprintf("% x", date)
  end
  return date
end

opt = OptionParser.new
opt.on('-y') {|v| p v }
opt.on('-m') {|v| p v }

# check arguments
unless ARGV.size == 0 || ARGV.size == 2 || ARGV.size == 4
  raise ArgumentError "please check number of ARGV."
end

if ARGV.size == 2
  unless ARGV.include?("-y") || ARGV.include?("-m")
    raise ArgumentError "invalid arguments"
  end
elsif ARGV.size == 4
   unless ARGV.include?("-y") && ARGV.include?("-m")
     raise ArgumentError "invalid arguments"
   end
end

# default value
year = Date.today.year
month = Date.today.month

# setting variables
if ARGV[0] == "-y"
  year = ARGV[1].to_i
elsif ARGV[2] == "-y"
  year = ARGV[3].to_i
end

if ARGV[0] == "-m"
  month = ARGV[1].to_i
elsif ARGV[2] == "-m"
  month = ARGV[3].to_i
end

first = Date.new(year, month, 1)
first_day = first.strftime('%a')
last = Date.new(year, month, -1)
day_count = last.day - first.day + 1
month_ary = []
week_ary = []
count = 0

# create calender array
(1..day_count).each do |day|
  if count == 0
    num = check_day(first)
    week_ary = Array.new(num, "  ")
    count += 1
  end

  date = Date.new(year, month, day)
  day = check_number(day)

  if date.strftime('%a') == "Sun" && date.day != 1
    month_ary << week_ary
    week_ary = []
    week_ary << day
  else
    week_ary << day
    month_ary << week_ary if day == last.day
  end

end

# print calender
days = ["日", "月", "火", "水", "木", "金", "土"]
joined_size = month_ary[0].join(" ").size
puts "#{month}月 #{year}".center(joined_size)
puts days.join(" ")
month_ary.each do |ary|
    puts ary.join(" ")
end
