#!/usr/bin/ruby

sum = 0
File.open('input.txt').each do |line|
  sum += ( line.to_i / 3 ) - 2 
end

puts sum

