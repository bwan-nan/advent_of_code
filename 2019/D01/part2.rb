#!/usr/bin/ruby

sum = 0
File.open('input.txt').each do |line|
  total_fuel = 0
  fuel_required = line.to_i / 3 - 2 
  while fuel_required >= 0 do
    total_fuel += fuel_required
    fuel_required = fuel_required / 3 - 2
  end
  sum += total_fuel
end

puts sum

