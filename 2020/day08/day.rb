require 'ap'

def part_1(instructions)
  visited_indexes = []
  acc = 0
  i = 0
  while instructions[i]
    break if visited_indexes.include?(i)
    visited_indexes << i
    next_i = 1
    cmd, val = instructions[i]
    case cmd
    when 'acc'
      acc += val.to_i
    when 'jmp'
      next_i = val.to_i
    when 'nop'
    end
    i += next_i
  end
  acc
end

def replace_instruction(instructions, i)
  # When duplicating array of arrays
  # instructions.dup doesn't work
  inst = Marshal.load(Marshal.dump(instructions)) # equivalent to instructions.dup.map(&:dup)
  if inst[i][0] == 'jmp'
    inst[i][0] = 'nop'
  else
    inst[i][0] = 'jmp'
  end
  inst
end

def part_2(instructions)
  instructions.each_with_index do |instruction, i|
    if instruction[0] != 'acc'
      inst = replace_instruction(instructions, i)
      acc = 0
      j = 0
      stop = 0
      while inst[j] && stop < 10000
        next_j = 1
        cmd, val = inst[j]
        case cmd
        when 'acc'
          acc += val.to_i
        when 'jmp'
          next_j = val.to_i
        when 'nop'
        end
        j += next_j
        stop += 1
      end
      return acc if stop < 10000
    end
  end
end

instructions = File.readlines('input.txt').map {|line| line.split(' ')}

puts part_1(instructions)
puts part_2(instructions)


