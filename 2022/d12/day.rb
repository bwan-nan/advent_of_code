require 'ap'
require 'set'


class Square
  attr_reader :letter, :x, :y
  attr_accessor :parent

  def initialize(x, y)
    @x = x
    @y = y
    @letter = $hill[y][x]
    @parent = nil
  end

  def eql?(other)
    x == other.x && y == other.y
  end

  def hash
    x * 1000 + y
  end

  def elevation
    return 0 if letter == 'S'
    return 'z'.ord - 'a'.ord if letter == 'E'
    letter.ord - 'a'.ord
  end

  def neighbors
    @_neighbors ||= get_neighbors
  end

  def get_neighbors
    n = [] #left, right, top, down
    n << Square.new(x - 1, y) if x - 1 >= 0 
    n << Square.new(x + 1, y) if x + 1 < $grid_width
    n << Square.new(x, y - 1) if y - 1 >= 0
    n << Square.new(x, y + 1) if y + 1 < $grid_height
    n
  end

  def can_visit?(neighbor)
    neighbor.elevation - elevation <= 1
  end

  def end?
    letter == 'E'
  end
  
  def start?
    letter == 'a' || letter == 'S'
  end
end

def get_path(end_node)
  node = end_node
  path = []
  while node.parent
    node = node.parent
    path.unshift(node)
  end
  path
end

def bfs(part)
  visited = Set.new
  queue = []
  end_node = nil

  $hill.each_with_index do |line, j|
    line.each_with_index do |letter, i|
      square = Square.new(i, j)
      queue << square if (part == 1 && letter == 'S') || (part == 2 && square.start?)
    end
  end

  until queue.empty?
    current_node = queue.shift

    next if visited.include?(current_node)
    visited << current_node
    if current_node.end?
      end_node = current_node
      break
    end

    current_node.neighbors.each do |neighbor|
      if current_node.can_visit?(neighbor)
        neighbor.parent = current_node
        queue << neighbor
      end
    end
  end
  end_node
end

$hill = File.readlines("input.txt").map {|l| l.strip.chars}
$grid_width = $hill[0].length
$grid_height = $hill.length

end_node = bfs(1)
path = get_path(end_node)
p path.length

end_node = bfs(2)
path = get_path(end_node)
p path.length
