require 'ap'

numbers = File.readlines('input.txt').map {|l| l.strip.split(',').map(&:to_i)}.first
said_numbers = {}
numbers.each_with_index do |number, i|
  said_numbers[number] = { indexes: [i] }
end

define_method(:add_number) do |number, current_idx|
  if said_numbers.has_key?(number)
    said_numbers[number][:indexes] << current_idx + 1
  else
    said_numbers[number] = { indexes: [ current_idx + 1 ] }
  end
end

define_method(:run) do |stop_limit|
  i = numbers.length - 1
  while i + 1 < stop_limit 
    number = numbers[i]
    new_number = nil
    if said_numbers[number][:indexes].count == 1
      new_number = 0
    else
      second_last_idx, last_idx = said_numbers[number][:indexes].last(2)
      new_number = last_idx - second_last_idx
    end
    add_number(new_number, i)
    numbers << new_number
    i += 1
  end
  numbers.last
end

p run 2020
p run 30000000 
