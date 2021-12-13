require 'ap'

class Point
  attr_accessor :x, :y, :visits_count

  def initialize(x, y)
    @x = x
    @y = y
    @visits_count = 0
  end

  def visit
    self.visits_count += 1
  end

  def reset!
    self.visits_count = 0
  end
end

input = File.readlines('input.txt').map {|l| l.strip!.split(' -> ')}

# 1000 * 1000 map
points = (0...1000000).map do |i|
  Point.new(i % 1000, i / 1000)
end.each_slice(1000).to_a


define_method :part_1 do |input|
  input.map do |start_point, end_point|
    a = Point.new(*start_point.split(',').map(&:to_i))
    b = Point.new(*end_point.split(',').map(&:to_i))
    if a.x == b.x
      sorted = [a.y, b.y].sort
      (sorted[1] + 1 - sorted[0]).times do |i|
        points[sorted[0] + i][a.x].visit
      end
    elsif a.y == b.y
      sorted = [a.x, b.x].sort
      (sorted[1] + 1 - sorted[0]).times do |i|
        points[a.y][sorted[0] + i].visit
      end
    end
  end
  points.flatten.select {|p| p.visits_count >= 2}.count
end

define_method :part_2 do |input|
  input.map do |start_point, end_point|
    a = Point.new(*start_point.split(',').map(&:to_i))
    b = Point.new(*end_point.split(',').map(&:to_i))
    if a.x == b.x
      sorted = [a.y, b.y].sort
      (sorted[1] + 1 - sorted[0]).times do |i|
        points[sorted[0] + i][a.x].visit
      end
    elsif a.y == b.y
      sorted = [a.x, b.x].sort
      (sorted[1] + 1 - sorted[0]).times do |i|
        points[a.y][sorted[0] + i].visit
      end
    elsif (a.x - b.x).abs == (a.y - b.y).abs
      dx = a.x - b.x
      dy = a.y - b.y
      ([dx.abs, dy.abs].max + 1).times do |i|
        dir_x = dx < 0 ? 1 : -1
        dir_y = dy < 0 ? 1 : -1
        x = a.x + dir_x * i
        y = a.y + dir_y * i
        points[y][x].visit
      end
    end
  end
  points.flatten.select {|p| p.visits_count >= 2}.count
end


puts part_1(input)
points.flatten.map(&:reset!)
puts part_2(input)
