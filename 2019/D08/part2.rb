#!/usr/bin/ruby
require 'ap'

def loop_for_color(layers, pixel)
  layers.each do |layer|
    return layer[pixel] unless layer[pixel] == 2
  end
  2
end

img = File.open('input.txt').map do |line|
  line.strip.split('').map(&:to_i)
end
img.flatten!

layer_size = 25 * 6
layers = img.each_slice(layer_size).to_a

first_layer = layers[0]

i = -1
msg = first_layer.map do |pixel|
  i += 1
  if pixel == 2
    loop_for_color(layers.dup, i)
  else
    pixel
  end
end

final_img = msg.each_slice(25).to_a

final_img.each do |layer|
  puts layer.join().gsub('0', ' ')
end
