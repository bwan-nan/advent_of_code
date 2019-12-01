#!/usr/bin/ruby

sum = 0
File.open('input1.txt').each do |line|
  sum += ( line.to_i / 3 ) - 2 
end

puts sum

