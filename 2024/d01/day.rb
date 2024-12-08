list1 = []
list2 = []
lines = File.readlines('input.txt').map do |l|
  a, b = l.split(%r{\s+}).map(&:to_i)
  list1 << a
  list2 << b
end

list1.sort!
list2.sort!

p1 = list1.map.with_index do |n, i|
  (n - list2[i]).abs
end.sum

p2 = list1.sum do |n|
  freq = list2.count(n)
  freq > 0 ? n * freq : 0
end


ap p2
