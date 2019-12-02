#!/usr/bin/ruby

sum = File.open('input.txt').inject(0) do |res, line|
  total_fuel = 0
  fuel_required = line.to_i / 3 - 2 
  while fuel_required > 0 do
    total_fuel += fuel_required
    fuel_required = fuel_required / 3 - 2
  end
  res + total_fuel
end

puts sum

