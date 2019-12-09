#!/usr/bin/ruby
require 'ap'
require 'scanf'



def int_to_reversed_array(n)
  array = []
  until n.zero?
   n, r = n.divmod(10)
   array.unshift(r)
  end
  array.reverse
end

def get_instruction_details(n)
  info = Struct.new(:op_code, :mod1, :mod2, :mod3)
  array = int_to_reversed_array(n)
  i = 0
  while i < array.length && array[i] == 0
    i += 1
  end
  if array[i] == 9 && array[i + 1] == 9
    op_code = 99
  else
    op_code = array[i]
  end
    i += 1
  info.new(
    op_code,
    array[i + 1] || 0,
    array[i + 2] || 0,
    array[i + 3] || 0
  )
end

def get_param_value(tab, value_at_index, mod)
  return value_at_index unless mod == 0
  tab[value_at_index]
end

def execute(tab, index, instruction)
  param1 = get_param_value(tab, tab[index + 1], instruction.mod1)
  param2 = get_param_value(tab, tab[index + 2], instruction.mod2)
  case instruction.op_code
  when 1
    tab[tab[index + 3]] = param1 + param2 unless instruction.mod3 == 1
    return 4
  when 2
    tab[tab[index + 3]] = param1 * param2 unless instruction.mod3 == 1
    return 4
  when 3
    tab[param1] = scanf('%d')
    return 2
  when 4
    puts param1
    return 2
  when 99
    return nil
  end
end


tab = File.open('input.txt').map do |line|
  line.split(',').map(&:to_i)
end

tab.flatten!
len = tab.length

initial_tab = tab.dup
i = 0
while i < len
  instruction = get_instruction_details(tab[i])
  ret = execute(tab, i, instruction)
  break if ret.nil?
  i += ret
end
