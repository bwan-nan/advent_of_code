require 'ap'
require 'set'

PIPES = {
  [-1, 0] => ["|", "7", "F"],
  [1, 0] => ["|", "L", "J"],
  [0, -1] => ["-", "L", "F"],
  [0, 1] => ["-", "7", "J"]
}

class Pipe
  attr_reader :letter, :x, :y
  attr_accessor :parent

  def initialize(x, y)
    @x = x
    @y = y
    @letter = $map[y][x]
    @parent = nil
  end

  def eql?(other)
    x == other.x && y == other.y
  end

  def hash
    x * 1000 + y
  end

  def neighbors
    @_neighbors ||= get_neighbors
  end

  def get_neighbors
    n = [] #left, right, top, down
    n << Pipe.new(x - 1, y) if x - 1 >= 0 
    n << Pipe.new(x + 1, y) if x + 1 < $grid_width
    n << Pipe.new(x, y - 1) if y - 1 >= 0
    n << Pipe.new(x, y + 1) if y + 1 < $grid_height
    n
  end

  def can_visit?(neighbor)
    dx = neighbor.x - self.x
    dy = neighbor.y - self.y
    PIPES[[dy, dx]].include?(neighbor.letter)
  end

  def end?(visited_nodes)
    return false if visited_nodes.empty?
    neighbors.all? {|neighbor| visited_nodes.include?(neighbor)}
  end
  
  def start?
    letter == 'S'
  end
end

def get_path(end_node)
  node = end_node
  path = []
  while node.parent
    node = node.parent
    path.prepend(node)
  end
  path
end

def bfs
  visited = Set.new
  queue = []
  paths = Set.new

  $map.each_with_index do |line, j|
    line.each_with_index do |letter, i|
      square = Pipe.new(i, j)
      queue << square if square.start?
    end
  end

  until queue.empty?
    current_node = queue.shift

    if visited.include?(current_node)
      paths << current_node.parent
      next
    end

    visited << current_node
    current_node.neighbors.each do |neighbor|
      if current_node.can_visit?(neighbor)
        neighbor.parent = current_node
        queue << neighbor
      end
    end
  end
  paths
end

$map = File.readlines('input.txt').map {|l| l.strip.chars}
$grid_width = $map[0].length
$grid_height = $map.length

end_nodes = bfs()

node = end_nodes.to_a.last
path = get_path(node).map(&:letter)
ap path.length
