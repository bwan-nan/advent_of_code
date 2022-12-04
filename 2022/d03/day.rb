rucksacks = File.readlines('input.txt').map(&:strip)

chars = rucksacks.map do |r|
  a, b = r.chars.each_slice(r.size / 2).map(&:join)
  a.chars & b.chars
end.flatten
p chars.map(&:ord).sum {|c| c >= 'a'.ord ? c - ('a'.ord - 1) : c - ('A'.ord - 27)}

chars = rucksacks.each_slice(3).map do |a, b, c|
  a.chars & b.chars & c.chars
end.flatten
p chars.map(&:ord).sum {|c| c >= 'a'.ord ? c - ('a'.ord - 1) : c - ('A'.ord - 27)}
