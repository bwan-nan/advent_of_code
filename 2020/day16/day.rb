require 'ap'

inputs = File.readlines('input.txt').map(&:strip)

valid_range = []

define_method(:build_valid_range) do |line|
  match = line.match(/\A(.+): (\d+-\d+) or (\d+-\d+)/)
  category, first_range, second_range = match[1], match[2], match[3]
#  ap [category, first_range, second_range]
  first_range = first_range.split('-').map(&:to_i)
  second_range = second_range.split('-').map(&:to_i)
  valid_range |= (first_range[0]..first_range[1]).to_a
  valid_range |= (second_range[0]..second_range[1]).to_a
end

step = 0
i = 0
my_ticket = nil
nearby_tickets = []
while inputs[i]
  if ['nearby tickets:', 'your ticket:'].include?(inputs[i])
    i += 1
    next
  end
  step += 1 if inputs[i] == ''
  case step
  when 0 then build_valid_range(inputs[i])
  when 1 then my_ticket = inputs[i].split(',').map(&:to_i)
  when 2 then nearby_tickets << inputs[i].split(',').map(&:to_i)
  end
  i += 1
end

#ap my_ticket
#ap nearby_tickets

invalid_values = nearby_tickets.map do |ticket|
  ticket.select do |val|
    !valid_range.include?(val)
  end
end.flatten

ap invalid_values.inject(:+)

