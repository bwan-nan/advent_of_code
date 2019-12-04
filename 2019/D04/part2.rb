#!/usr/bin/ruby

def check_order(num)
  sorted_array = num.chars.sort
  num.chars == sorted_array
end

def check_occurences(digit1, num)
  num.count(digit1) == 2
end

def adjacent_digits(num)
  i = 0
  while i < 5
    digit1 = num[i]
    digit2 = num[i + 1]
    if digit1 == digit2
      return true if check_occurences(digit1, num)
    end
    i += 1
  end
  false
end

def valid_password(num)
  check_order(num.to_s) && adjacent_digits(num.to_s)
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
