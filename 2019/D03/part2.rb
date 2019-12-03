#!/usr/bin/ruby
require 'ap'

#draw a point for each coordinate in the trajectory
def draw_points(instructions, point)
  points = []
  instructions.each do |move|
    length = move.scan(/\d+/).first.to_i
    case move[0]
    when 'U'
      for i in 0...length
	point[:y] += 1
	points << point.dup
      end
    when 'D'
      for i in 0...length
	point[:y] -= 1
	points << point.dup
      end
    when 'L'
      for i in 0...length
	point[:x] -= 1
	points << point.dup
      end
    when 'R'
      for i in 0...length
	point[:x] += 1
	points << point.dup
      end
    end
  end
  points
end

def calculate_steps(point, wire1, wire2)
  wire1.index(point) + wire2.index(point) + 2 #add 2 because an array starts at index 0
end

wire_instructions = File.open('input.txt').map do |line|
  line.strip.split(',')
end

origin = {
  x: 0,
  y: 0
}

points = wire_instructions.map do |instructions|
  draw_points(instructions, origin.dup)
end

intersections = points[0] & points[1]

steps = intersections.map do |point|
  calculate_steps(point, points[0], points[1])
end

puts steps.min
