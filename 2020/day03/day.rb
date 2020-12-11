require 'ap'

Coordinates = Struct.new(:y, :x, :delta_x, :delta_y, :tree_count) do
  def still_in_map?(map)
    map[self.y]
  end

  def slide_down(map)
    self.x = (self.x + self.delta_x) % map[0].length 
    self.y += self.delta_y
    increment_tree_count(map)
  end

  def increment_tree_count(map)
    if map[self.y]
      self.tree_count += map[self.y][self.x] == '#' ? 1 : 0
    end
  end
end

map = File.readlines('input.txt').map {|line| line.strip!}

puts  map[0].length

coords_tab = []
coords_tab << Coordinates.new(0, 0, 1, 1, 0)
coords_tab << Coordinates.new(0, 0, 3, 1, 0)
coords_tab << Coordinates.new(0, 0, 5, 1, 0)
coords_tab << Coordinates.new(0, 0, 7, 1, 0)
coords_tab << Coordinates.new(0, 0, 1, 2, 0)

trees_encountered = coords_tab.map do |coords|
  while (coords.still_in_map?(map))
    coords.slide_down(map)
  end
  ap coords
  coords.tree_count
end

ap trees_encountered.inject(:*)
