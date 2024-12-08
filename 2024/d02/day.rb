def ordered?(list)
  ascending = true
  descending = true

  list.each_cons(2).with_index do |(a, b), i|
    diff = (a - b).abs
    ascending = false if a >= b || diff > 3
    descending = false if a <= b || diff > 3

    break unless ascending || descending # Exit early if neither order holds
  end

  ascending || descending
end

def more_or_less_ordered?(list)
  return true if ordered?(list)
  list.each_with_index.any? do |_, i|
    new_list = list.dup
    new_list.delete_at(i)
    ordered?(new_list)
  end
end

reports = File.readlines('input.txt').map do |l|
  l.split(%r{\s+}).map(&:to_i)
end

p reports.count {|r| ordered?(r)}

p reports.count {|r| more_or_less_ordered?(r)}
