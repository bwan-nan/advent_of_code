require 'json'
require 'set'

UNORDERED = -1
ORDERED = 1
EQUALITY = 0

def compare(a, b)
  return UNORDERED if a && !b
  return ORDERED if !a && b

  if a.class == Integer && b.class == Integer
    return EQUALITY if a == b
    return ORDERED if a < b
    return UNORDERED
  end

  return compare(a, [b]) if a.class == Array && b.class == Integer
  return compare([a], b) if a.class == Integer && b.class == Array

  if a.class == Array && b.class == Array
    i = 0
    while a[i]
      res = compare(a[i], b[i])
      return res if [UNORDERED, ORDERED].include?(res)
      i += 1
    end
    return ORDERED if b[i]
  end
  EQUALITY
end

pairs = File.read('input.txt').split("\n\n").map {|l| l.split("\n").map {|p| JSON.parse(p)}}

sum = 0
pairs.each_with_index {|(a, b), i| sum += i + 1 if compare(a, b) >= 0}
puts sum

items = pairs.flatten(1)
divider_packets = [ [[2]], [[6]] ]

items.concat(divider_packets)
items.sort! {|x, y| -compare(x, y)}
puts divider_packets.map {|divider_packet| items.index(divider_packet) + 1}.inject(:*)
