def part_1(numbers)
  magic_numbers = numbers.combination(2).detect {|a, b| a + b == 2020}
  magic_numbers[0] * magic_numbers[1]
end

def part_2(numbers)
  magic_numbers = numbers.combination(3).detect {|a, b, c| a + b + c == 2020}
  magic_numbers[0] * magic_numbers[1] * magic_numbers[2]
end

numbers = []
File.readlines('input.txt').each {|line| numbers << line.strip!.to_i }

puts part_1(numbers)
puts part_2(numbers)
