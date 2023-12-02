input = File.readlines('input.txt')

games = []

input.each_with_index do |line, game_index|
  games[game_index] = []
  game_number, sets = line.split(": ")

  sets.split("; ").each_with_index do |set, set_index|
    games[game_index][set_index] = {}

    set.split(", ").each do |cubes|
      number, color = cubes.split(" ")
      games[game_index][set_index][color] = number.to_i
    end
  end
end

elf_bag = {
  "red" => 12,
  "green" => 13,
  "blue" => 14
}

def all_sets_possible?(game, elf_bag)
  game.all? do |set|
    set.all? {|color, n| n <= elf_bag[color]}
  end
end

possible_games = []
minimum_cube_nb = []

games.each_with_index do |game, i|
  possible_games << i + 1 if all_sets_possible?(game, elf_bag)
  minimum_cube_nb << {"red" => 0, "blue" => 0, "green" => 0}

  game.each do |set|
    set.each do |color, n|
      minimum_cube_nb[i][color] = n if n > minimum_cube_nb[i][color]
    end
  end
end

p1 = possible_games.sum
puts p1

p2 = minimum_cube_nb.sum do |game|
  game.map{|color, n| n}.inject(:*)
end
puts p2
