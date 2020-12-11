require 'ap'

# Really slow ~4s for part1 and ~8s for part2
original_map = File.readlines('input.txt').map(&:strip)
map = original_map.map(&:dup)
IMAX = map.length - 1
JMAX = map[0].length - 1

# Discovered that #define_method can be used to have access to global variable 'map'
# in any of the methods without having to pass it in parameter

define_method(:look_further) do |row, col, di, dj|
  while row.between?(0, IMAX) && col.between?(0, JMAX) \
      && map[row][col] && map[row][col] == '.'
    row += di if di != 0
    col += dj if dj != 0
  end
  [row, col]
end

define_method(:occupied_seats_around) do |part_nb, i, j|
  occupied_adj_seats = 0
  [-1, 0, 1].map do |di|
    [-1, 0, 1].map do |dj|
      if !(di == 0 && dj == 0)
        new_row = i + di
        new_col = j + dj
        new_row, new_col = look_further(new_row, new_col, di, dj) if part_nb == 2
        if new_row.between?(0, IMAX) && new_col.between?(0, JMAX)  
          occupied_adj_seats += 1 if map[new_row][new_col] == '#'
        end
      end
    end
  end
  occupied_adj_seats
end

define_method(:part) do |part_nb|
  while 1
   # ap map
   # puts '', ''
    changed = false
    new_map = map.map(&:dup)

    map.each_with_index do |row, i|
      row.chars.each_with_index do |seat, j|
        occ_seats_around = occupied_seats_around(part_nb, i, j)
        if seat == 'L' && occ_seats_around == 0
          new_map[i][j] = '#'
          changed = true
        elsif seat == '#' && occ_seats_around >= (part_nb == 1 ? 4 : 5)
          new_map[i][j] = 'L'
          changed = true
        end
      end
    end
    break if !changed
    map = new_map.map(&:dup)
  end
  occupied_seats = new_map.sum {|row| row.count('#')}
end

puts part(1)
map = original_map
puts part(2)
