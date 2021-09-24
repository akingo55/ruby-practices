#!/usr/bin/env ruby

def fizzbuzz(num)
  if num % 15 == 0
    puts "FizzBuzz"
  elsif num % 5 == 0
    puts "Buzz"
  elsif num % 3 == 0
    puts "Fizz"
  else
    puts num
  end
end


[*1..20].each do |num|
  fizzbuzz(num)
end
