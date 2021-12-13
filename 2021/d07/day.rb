require 'ap'

def part_1(list)
  min, max = list.min, list.max
  hash = (min..max).inject({}) do |h, n|
    h[n] = list.sum {|k| (k - n).abs}
    h
  end
  hash.min_by {|k, v| v}.last
end

def part_2(list)
  min, max = list.min, list.max
  hash = (min..max).inject({}) do |h, n|
    h[n] = list.sum {|k| (0..(k - n).abs).sum}
    h
  end
  hash.min_by {|k, v| v}.last
end

list = File.readlines('input.txt').map {|l| l.strip!.split(',').map(&:to_i)}.first


puts part_1(list)
puts part_2(list)
