#!/usr/bin/ruby
require 'ap'

img = File.open('input.txt').map do |line|
  line.strip.split('').map(&:to_i)
end
img.flatten!

layer_size = 25 * 6
layers = img.each_slice(layer_size).to_a


zeros_count = 150
layer_index = 0
i = 0

layers.each do |layer|
  if layer.count(0) < zeros_count
    zeros_count = layer.count(0)
    layer_index = i
  end
  i += 1
end

ones_count = layers[layer_index].count(1) 
twos_count = layers[layer_index].count(2) 

puts ones_count * twos_count
