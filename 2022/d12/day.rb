require 'ap'
require 'set'

Position = Struct.new(:x, :y) do
  def eql?(other)
    x == other.x && y == other.y
  end

  def hash
    x * 1000 + y
  end
end

class Square
  attr_reader :letter, :position
  attr_accessor :parent

  def initialize(position)
    @position = position
    @letter = $hill[position.y][position.x]
    @letter = 'a' if letter == 'S'
    @letter = 'z' if letter == 'E'
    @parent = nil
  end

  def eql?(other)
    x == other.x && y == other.y
  end

  def hash
    x * 1000 + y
  end

  def elevation
    letter.ord - 'a'.ord
  end

  def neighbors
    @_neighbors ||= get_neighbors
  end

  def get_neighbors
    n = [] #left, right, top, down
    n << Square.new(Position.new(position.x - 1, position.y)) if position.x - 1 >= 0 
    n << Square.new(Position.new(position.x + 1, position.y)) if position.x + 1 < $row_len
    n << Square.new(Position.new(position.x, position.y - 1)) if position.y - 1 >= 0
    n << Square.new(Position.new(position.x, position.y + 1)) if position.y + 1 < $col_len
    n
  end

  def x
    position.x
  end

  def y
    position.y
  end

  def can_visit?(neighbor)
    return false if already_visited?(neighbor)
    neighbor.elevation - elevation <= 1
  end

  def already_visited?(neighbor)
    $visited.include?(neighbor)
  end

  def end?
    @_end ||= $end_position.x == x && $end_position.y == y
  end
  
  def s_node?
    @_s_node ||= $s_position.x == x && $s_position.y == y
  end
end

def get_path(end_point)
  node = end_point
  path = []
  while node.parent
    node = node.parent
    path.unshift(node)
  end
  path
end

def bfs(start_node)
  queue = []
  end_point = nil

  queue << start_node
  $visited << start_node

  until queue.empty?
    current_node = queue.shift

    if current_node.end?
      end_point = current_node
      break
    end

    current_node.neighbors.each do |neighbor|
      if current_node.can_visit?(neighbor)
        neighbor.parent = current_node
        queue << neighbor
        $visited << neighbor
      end
    end
  end
  end_point
end

def get_positions
  start_pos = []
  end_pos = nil
  s_pos = nil
  $hill.each_with_index do |line, j|
    line.each_with_index do |letter, i|
      start_pos << Position.new(i, j) if letter == 'a' || letter == 'S'
      s_pos = Position.new(i, j) if letter == 'S'
      end_pos = Position.new(i, j) if letter == 'E'
    end
  end
  [start_pos, s_pos, end_pos]
end

$hill = File.readlines("input.txt").map {|l| l.strip.chars}
$row_len = $hill[0].length
$col_len = $hill.length
a_positions, $s_position, $end_position = get_positions

paths = []
s_path_len = 0
a_positions.each do |a_position|
  $visited = Set.new
  start_node = Square.new(a_position)
  end_point = bfs(start_node)
  if end_point
    path = get_path(end_point)
    paths << path
    p path.length if start_node.s_node?
  end
end

p paths.sort_by(&:size).first.size
