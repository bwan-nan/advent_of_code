class Point
  attr_accessor :x, :y, :o_x, :o_y

  def initialize(x, y)
    @x = x
    @y = y
    @o_x = x
    @o_y = y
  end

  def dx
    x - o_x
  end

  def dy
    y - o_y
  end
end

class Head < Point
  def initialize(*args)
    super
  end

  def move(direction, step)
    @o_x, @o_y = x, y
    case direction
    when 'L'then @x -= step
    when 'R' then @x += step
    when 'U' then @y += step
    when 'D' then @y -= step
    end
  end

end

class Tail < Point
  attr_reader :head

  def initialize(*args)
    super
  end

  def follow(head)
    @head = head
    @o_x, @o_y = x, y
    return if no_need_to_move?

    if [head.dx.abs, head.dy.abs] == [1, 1] && horizontal_dist_to_head != 0 && vertical_dist_to_head != 0
      @x += head.dx
      @y += head.dy
      return self
    end

    @x += head.x - self.x > 0 ? 1 : -1 if horizontal_dist_to_head > 0
    @y += head.y - self.y > 0 ? 1 : -1 if vertical_dist_to_head > 0
    self
  end

  def horizontal_dist_to_head
    (head.x - self.x).abs
  end

  def vertical_dist_to_head
    (head.y - self.y).abs
  end

  def no_need_to_move?
    horizontal_dist_to_head <= 1 && vertical_dist_to_head <= 1
  end
end

lines = File.readlines('input.txt').map {|l| l.strip.split}

head = Head.new(0, 0) 
tail = Tail.new(0, 0) 

tails = 9.times.map { tail.dup }
tail_positions_p1 = [tail.dup]
tail_positions_p2 = [tail.dup]

lines.map do |direction, step|
  step = step.to_i
  #puts "#{direction} #{step}"
  step.times do |i|
    head.move(direction, 1)

    tails.each_with_index do |point, i|
      point_to_follow = i == 0 ? head : tails[i - 1]
      moved = point.follow(point_to_follow)
      tail_positions_p1 << point.dup if moved && i == 0
      tail_positions_p2 << point.dup if moved && i == 8
    end
  end
end

# DEBUG MAP
#(0..50).map do |j|
#  (0..50).map do |i|
#    if tail_positions_p2.detect {|p| p.x + 30 == i && -p.y + 30 == j}
#      print '#'
#    else
#      print '.'
#    end
#  end
#  puts "\n"
#end

p tail_positions_p1.uniq{|t| [t.x, t.y]}.count
p tail_positions_p2.uniq{|t| [t.x, t.y]}.count
