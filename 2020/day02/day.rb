def part_1(inputs)
  inputs.inject(0) do |sum, input|
    n, letter, password = input
    letter = letter[0...-1]
    min, max = n.split('-').map(&:to_i)
    letter_occurence = password.count(letter)
    sum += 1 if letter_occurence >= min && letter_occurence <= max
    sum
  end
end

def part_2(inputs)
  inputs.inject(0) do |sum, input|
    n, letter, password = input
    letter = letter[0...-1]
    index1, index2 = n.split('-').map(&:to_i)
    if (password[index1 - 1] == letter) ^ (password[index2 - 1] == letter)
      sum += 1 
    end
    sum
  end
end

inputs = File.readlines('input.txt').map {|line| line.split(' ')}



puts part_1(inputs)
puts part_2(inputs)
