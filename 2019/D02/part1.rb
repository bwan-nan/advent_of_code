#!/usr/bin/ruby

tab = []
File.open('input.txt').each do |line|
  tab = line.split(',').map(&:to_i)
end

tab[1] = 12
tab[2] = 2

i = 0
tab.each do |elem|
  if i == 0 or i % 4 == 0
    if elem == 1
      tab[tab[i + 3]] = tab[tab[i + 1]] + tab[tab[i + 2]]
    elsif elem == 2
      tab[tab[i + 3]] = tab[tab[i + 1]] * tab[tab[i + 2]]
    elsif elem == 99
      break
    end
  end
  i += 1
end

puts tab[0]

