require 'ap'

datastream = File.read('input.txt').strip

start_of_packet_marker = datastream.chars.each_cons(4).detect {|chars| chars.uniq.count == 4}.join
p datastream.index(start_of_packet_marker) + start_of_packet_marker.size

start_of_packet_marker = datastream.chars.each_cons(14).detect {|chars| chars.uniq.count == 14}.join
p datastream.index(start_of_packet_marker) + start_of_packet_marker.size
