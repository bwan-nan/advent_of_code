#!/usr/bin/ruby

sum = File.open('input.txt').inject(0) do |res, line|
  res + line.to_i / 3 - 2 
end

puts sum

