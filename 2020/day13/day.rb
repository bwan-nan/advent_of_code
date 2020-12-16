require 'ap'

PossibleDeparture = Struct.new(:bus_id, :time, :ETA)

inputs = File.readlines('input.txt').map do |line|
  line.strip!
  line.split(',')
end

departure_point, bus_lines = inputs[0][0].to_i, inputs[1]
lines_in_service = (bus_lines.uniq - ['x']).map(&:to_i)
#ap lines_in_service

possible_times_of_departure = lines_in_service.map do |bus_id|
  time = departure_point - departure_point % bus_id + bus_id
  PossibleDeparture.new(bus_id, time, time - departure_point)
end.sort_by(&:ETA)

#ap possible_times_of_departure
s = possible_times_of_departure.first
puts s.ETA * s.bus_id

