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
  op_code = ( array[i] == 9 && array[i + 1] == 9 ) ? 99 : array[i]
  i += 1
  info.new(
    op_code,
    !array[i + 1].nil? && array[i + 1] == 1 ? 1 : 0,
    !array[i + 2].nil? && array[i + 2] == 1 ? 1 : 0,
    !array[i + 3].nil? && array[i + 3] == 1 ? 1 : 0
  )
end

def get_param_value(tab, value_at_index, mod)
  return value_at_index unless mod == 0
  tab[value_at_index]
end

def execute(tab, index, instruction)
  return nil if instruction.op_code == 99
  param1 = get_param_value(tab, tab[index + 1], instruction.mod1)
  param2 = get_param_value(tab, tab[index + 2], instruction.mod2)
  case instruction.op_code
  when 1
    tab[tab[index + 3]] = param1 + param2
    return 4
  when 2
    tab[tab[index + 3]] = param1 * param2
    return 4
  when 3
    tab[tab[index + 1]] = scanf('%d').first
    return 2
  when 4
    puts param1
    return 2
  when 5
    return [ :jump, param2 ] if param1 != 0 
    return 3
  when 6
    return [ :jump, param2 ] if param1 == 0 
    return 3
  when 7
    tab[tab[index + 3]] = param1 < param2 ? 1 : 0
    return 4
  when 8
    tab[tab[index + 3]] = param1 == param2 ? 1 : 0
    return 4
  end
end


tab = File.open('input.txt').map do |line|
  line.split(',').map(&:to_i)
end

tab.flatten!
len = tab.length

i = 0
while i < len
  instruction = get_instruction_details(tab[i])
  ret = execute(tab, i, instruction)
  if ret.kind_of?(Array)
    i = ret[1]
  elsif ret == nil
    break
  else
    i += ret
  end
end

