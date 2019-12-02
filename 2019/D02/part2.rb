#!/usr/bin/ruby

def test_pair(tab, noun, verb)
  tab[1] = noun 
  tab[2] = verb
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
  tab[0]
end

initial_tab = []
File.open('input.txt').each do |line|
  initial_tab = line.split(',').map(&:to_i)
end

j = 0
while j < 100 do
  k = 0
  while k < 100 do
    if test_pair(initial_tab.dup, j, k) == 19690720
      puts 100 * j + k
      break
    end
    k += 1
  end
  j += 1
end

