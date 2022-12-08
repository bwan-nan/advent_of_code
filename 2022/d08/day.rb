require 'ap'

def is_visible(grid, x, y, grid_length)
  (0...x).select {|i| grid[y][i] < grid[y][x]}.count == (0...x).count \
    || ((x + 1)..(grid_length - 1)).select {|i| grid[y][i] < grid[y][x]}.count  == ((x + 1)..(grid_length - 1)).count \
    || (0...y).select {|j| grid[j][x] < grid[y][x]}.count == (0...y).count \
    || ((y + 1)..(grid_length - 1)).select {|j| grid[j][x] < grid[y][x]}.count == ((y + 1)..(grid_length - 1)).count
end

def left_score(grid, x, y)
  score = 0
  (0...x).to_a.reverse.each do |i|
    score += 1
    break if grid[y][i] >= grid[y][x]
  end
  score
end

def right_score(grid, x, y, grid_length)
  score = 0
  ((x + 1)..(grid_length - 1)).each do |i|
    score += 1
    break if grid[y][i] >= grid[y][x]
  end
  score
end

def top_score(grid, x, y)
  score = 0
  (0...y).to_a.reverse.each do |j|
    score += 1
    break if grid[j][x] >= grid[y][x]
  end
  score
end

def down_score(grid, x, y, grid_length)
  score = 0
  ((y + 1)..(grid_length - 1)).each do |j|
    score += 1
    break if grid[j][x] >= grid[y][x]
  end
  score
end

def get_scenic_score(grid, x, y, grid_length)
  left = left_score(grid, x, y)
  right = right_score(grid, x, y, grid_length)
  top = top_score(grid, x, y)
  down = down_score(grid, x, y, grid_length)
  left * right * top * down
end

grid = File.readlines('input.txt').map {|l| l.strip.chars.map(&:to_i)}

grid_length = grid.count
borders = grid_length * 2 - 4 + 2 * grid_length

visible_trees = borders
scenic_scores = []

grid.each_with_index do |tree_line, j|
  next if j == 0 || j == grid_length - 1
  tree_line.each_with_index do |tree, i|
    next if i == 0 || i == grid_length - 1
    visible_trees += 1 if is_visible(grid, i, j, grid_length) 
    scenic_scores << get_scenic_score(grid, i, j, grid_length)
  end
end

p visible_trees
p scenic_scores.max


