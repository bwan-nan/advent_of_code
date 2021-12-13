numbers = File.readlines('input.txt').map {|line| line.strip!.to_i }

def part_1(numbers)
  count = 0
  numbers.each_cons(2) do |a, b|
    count += 1 if a < b
  end
  count
end

def part_2(numbers)
  count = 0
  numbers.each_cons(3).map(&:sum).each_cons(2) do |a, b|
    count += 1 if a < b
  end
  count
end

puts part_1(numbers)
puts part_2(numbers)
