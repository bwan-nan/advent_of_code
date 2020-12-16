require 'ap'

Direction = Struct.new(:cardinal_point) do
  def opposite(waypoint=nil)
    if waypoint
      waypoint.north *= -1
      waypoint.east *= -1
    end
    case self.cardinal_point
    when 'N' then 'S' 
    when 'S' then 'N'
    when 'E' then 'W'
    when 'W' then 'E'
    end
  end

  def left(waypoint=nil)
    if waypoint
      north, east = [waypoint.north, waypoint.east]
      waypoint.north = east
      waypoint.east = north * -1
    end
    case self.cardinal_point
    when 'N' then 'W' 
    when 'S' then 'E'
    when 'E' then 'N'
    when 'W' then 'S'
    end
  end

  def right(waypoint=nil)
    if waypoint
      north, east = [waypoint.north, waypoint.east]
      waypoint.north = east * -1
      waypoint.east = north
    end
    case self.cardinal_point
    when 'N' then 'E' 
    when 'S' then 'W'
    when 'E' then 'S'
    when 'W' then 'N'
    end
  end
end

Position = Struct.new(:north, :east, :facing) do
  def move(direction, value)
    case direction
    when 'N' then self.north += value
    when 'S' then self.north -= value
    when 'E' then self.east += value
    when 'W' then self.east -= value
    end
  end

  def turn(direction, value)
    d = Direction.new(self.facing)
    if value == 180
      self.facing = d.opposite
    elsif direction == 'L'
      self.facing = value == 270 ? d.right : d.left
    else
      self.facing = value == 270 ? d.left : d.right 
    end
  end

  def move_forward(value, part_nb)
    move(self.facing, value)
  end

  def turn_waypoint(direction, value)
    d = Direction.new(self.facing)
    if value == 180
      self.facing = d.opposite(self)
    elsif direction == 'L'
      self.facing = value == 270 ? d.right(self) : d.left(self)
    else
      self.facing = value == 270 ? d.left(self) : d.right(self)
    end
  end

  def move_to_waypoint(waypoint, n_times)
    move('N', waypoint.north * n_times)
    move('E', waypoint.east * n_times)
  end
end

instructions = File.readlines('input.txt').map(&:strip)
position = Position.new(0, 0, 'E')
waypoint = Position.new(1, 10, 'E')

define_method(:part) do |part_nb|
  instructions.each do |instruction|
   # ap [ waypoint, position, instruction ]
    action = instruction[0]
    val = instruction.match(/\d+/)[0].to_i
    case action
    when *['N', 'S', 'E','W']
      part_nb  == 1 ? position.move(action, val) : waypoint.move(action, val)
    when *['L', 'R']
      part_nb == 1 ? position.turn(action, val) : waypoint.turn_waypoint(action, val)
    when 'F'
      part_nb == 1 ? position.move_forward(val, part_nb) : position.move_to_waypoint(waypoint, val)
    end
  end
  position.north.abs + position.east.abs
end

puts part(1)
position = Position.new(0, 0, 'E')
puts part(2)
