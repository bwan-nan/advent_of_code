require 'set'

pairs = File.readlines('input.txt').map {|l| l.strip.split(',')}

p1, p2 = [0, 0]
pairs.map do |a, b|
  a_set = Range.new(*a.split('-').map(&:to_i)).to_set
  b_set = Range.new(*b.split('-').map(&:to_i)).to_set
  p1 += 1 if a_set.subset?(b_set) || b_set.subset?(a_set)
  p2 += 1 if (a_set & b_set).count > 0
end.count

p p1
p p2
