#!/usr/bin/env ruby

def fizzbuzz(num)
  if num % 15 == 0
    'FizzBuzz'
  elsif num % 5 == 0
    'Buzz'
  elsif num % 3 == 0
    'Fizz'
  else
    num
  end
end


(1..20).each do |num|
  fizzbuzz(num)
end
