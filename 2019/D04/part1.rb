#!/usr/bin/ruby

def check_order(num)
  sorted_array = num.chars.sort
  num.chars == sorted_array
end

def at_least_two_adjacent_digits(num)
  i = 0
  while i < 5
    digit1 = num[i]
    digit2 = num[i + 1]
    return true if digit1 == digit2
    i += 1
  end
  false
end

def valid_password(num)
  check_order(num.to_s) && at_least_two_adjacent_digits(num.to_s)
end

range = File.open('input.txt').first
min = range.split('-').first.to_i
max = range.split('-').last.to_i

count = 0
for i in min..max
  if valid_password(i)
    count += 1
  end
end

puts count
