require 'set'

class Guard
  attr_accessor :x, :y, :next_move

  def initialize(x, y)
    @x = x
    @y = y
    @next_move = up
  end

  def continue_patrol(grid)
    grid_length = grid.length
    x_next, y_next = [@x + @next_move[1], @y + @next_move[0]]


    if x_next >= 0 && y_next >= 0 \
        && x_next < grid_length && y_next < grid_length

      if grid[y_next][x_next] == '#'
        compute_next_move
        return continue_patrol(grid)
      end

      @x = x_next
      @y = y_next
      [@x, y]
    end
  end

  def compute_next_move
    @next_move =
      case next_move
      when up then right
      when down then left
      when left then up
      when right then down
      end
  end

  def up
    [-1, 0]
  end

  def down
    [1, 0]
  end

  def right
    [0, 1]
  end

  def left
    [0, -1]
  end
end

grid = File.readlines('input.txt').map {|l| l.strip.chars}

guard = nil

grid.each_with_index do |line, j|
  line.each_with_index do |char, i|
    guard = Guard.new(i, j) if char == '^'
  end
end

visited = Set.new([[guard.x, guard.y]])

loop do
  new_location = guard.continue_patrol(grid)
  if new_location
    visited << new_location
  else
    break
  end
end

p visited.count
