require 'ap'

def part_1(preamble, coming_numbers, numbers)
  i = 0
  while coming_numbers.first
    number = coming_numbers.shift
    combos = preamble.combination(2)
    a, b = combos.detect {|a, b| a + b == number}
    return number if !a
    i += 1
    # Shift the 25-number preamble to the right
    preamble = numbers[i..(i + 24)]
  end
end

def part_2(magic_number, numbers)
  # Find a contiguous set of at least two numbers
  # which sum to the invalid number from step 1
  contiguous_rule = 2
  while 1
    magic_numbers = numbers.each_cons(contiguous_rule).detect do |numbers|
      numbers.sum == magic_number
    end
    return magic_numbers.min + magic_numbers.max if magic_numbers
    contiguous_rule += 1
  end
end

numbers = File.readlines('input.txt').map(&:to_i)

# 25-number preamble
preamble = numbers[0..24]
coming_numbers = numbers[25..-1]

magic_number = part_1(preamble, coming_numbers, numbers)
puts magic_number

puts part_2(magic_number, numbers)

