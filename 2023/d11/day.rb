def sum_distances_between_planets(planets, empty_rows, empty_cols, expansion_factor)
  planets.combination(2).sum do |a, b|
    man_dist = (b.y - a.y).abs + (b.x - a.x).abs
    rx = [b.x, a.x].sort
    ry = [b.y, a.y].sort

    dx = empty_cols.sum {|i| i.between?(*rx) ? expansion_factor : 0}
    dy = empty_rows.sum {|j| j.between?(*ry) ? expansion_factor : 0}
    man_dist + dx + dy
  end
end

Planet = Struct.new(:x, :y)

lines = File.readlines('input.txt').map {|l| l.strip.chars}

empty_rows = []
lines.each_with_index do |line, j|
  empty_rows << j if !line.include?('#')
end
empty_rows.sort!

empty_cols = []
i = 0
col_len = lines[0].length
while i < col_len
  empty_cols << i if lines.all? {|line| line[i] == '.'}
  i += 1
end
empty_cols.sort!

planets = []
lines.each_with_index do |line, j|
  line.each_with_index do |char, i|
    planets << Planet.new(i, j) if char == '#'
  end
end

puts sum_distances_between_planets(planets, empty_rows, empty_cols, 1)
puts sum_distances_between_planets(planets, empty_rows, empty_cols, 1_000_000 - 1)
