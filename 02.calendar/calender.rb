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

params = {}
opt = OptionParser.new
opt.on('-y year') { |year| params[:year] = year}
opt.on('-m month') { |month| params[:month] = month}
opt.parse!(ARGV)

# default value
year = params[:year] == nil ? Date.today.year : params[:year].to_i
month = params[:month] == nil ? Date.today.month : params[:month].to_i

# setting variables
first = Date.new(year, month, 1)
last = Date.new(year, month, -1)
day_count = last.day - first.day + 1
month_ary = []
num = check_day(first)
week_ary = Array.new(num, "  ")

# create calender array
(1..day_count).each do |day|
  date = Date.new(year, month, day)
  day = check_number(day)

  if date.strftime('%a') == "Sat"
    week_ary << day
    month_ary << week_ary
    week_ary = []
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
