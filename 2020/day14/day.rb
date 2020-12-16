require 'ap'

MemoryModif = Struct.new(:address, :value)

class Mask
  attr_accessor :mask, :modifications, :values

  def initialize(mask, modifications)
    @mask = mask
    @modifications = modifications
    @values = {}
  end

end

inputs = File.readlines('input.txt').map(&:strip)
inputs << nil

masks = []
i = 0
while inputs[i]
  if inputs[i] =~ /^mask/
    mask = inputs[i].split(' = ').last
    i += 1
    memory_modifs = []
    while inputs[i] && !(inputs[i] =~ /^mask/)
      address, value = inputs[i].split(' = ')
      address = address.match(/\d+/)[0].to_i
      value = value.to_i
      memory_modifs << MemoryModif.new(address, value)
     # puts inputs[i]
      i += 1
    end
    masks <<  Mask.new(mask, memory_modifs)
  end
end

memory = {}
masks.each do |mask|
  mask.modifications.each do |modification|
    res = mask.mask.reverse if !res
    value = modification.value.to_s(2).reverse
    value.chars.each_with_index do |bit, i|
      res[i] = bit if res[i] == 'X'
    end
    mask.values[modification.address] = res.reverse.tr('X', '0').to_i(2)
    memory[modification.address] = mask.values[modification.address]
  end
end

puts memory.values.inject(:+)
