require 'ap'

grid = File.readlines('input.txt').map {|l| l.strip.chars}


$directions = [
  [1, 0],
  [0, 1],
  [-1, 0],
  [0, -1],
  [-1, 1],
  [1, -1],
  [-1, -1],
  [1, 1]
]


def p1_count(grid, x, y)
  xmas_count = 0
  $directions.each do |dx, dy|
    # Track coordinates and match "XMAS" sequentially
    valid = true
    x_current, y_current = x, y

    %w(X M A S).each_with_index do |char, idx|
      if x_current < 0 || y_current < 0 || grid[y_current]&.[](x_current) != char
        valid = false
        break
      end
      x_current += dx
      y_current += dy
    end

    xmas_count += 1 if valid
  end
  xmas_count
end

p1 = 0

grid.each_with_index do |line, j|
  line.each_with_index do |letter, i|
    if letter == 'X'
      p1 += p1_count(grid, i, j)
    end
  end
end



ap p1


def xmas_cross?(grid, x, y)
  return false if x - 1 < 0 || y - 1 < 0

  diagonals = [
    [grid[y - 1]&.[](x - 1), grid[y + 1]&.[](x + 1)],
    [grid[y + 1]&.[](x - 1), grid[y - 1]&.[](x + 1)]
  ]

  diagonals.all? do |(a, b)|
    (a == 'M' && b == 'S') || (a == 'S' && b == 'M')
  end
end

p2 = 0
grid.each_with_index do |line, j|
  line.each_with_index do |letter, i|
    if letter == 'A'
      p2 += 1 if xmas_cross?(grid, i, j)
    end
  end
end

ap p2
