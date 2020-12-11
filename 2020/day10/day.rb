require 'ap'

# https://www.youtube.com/watch?v=cE88K2kFZn0
DynamicProgramming = Struct.new(:adapters, :nb_of_paths_from) do
  def count_paths_to_end_point(start_point)
    return 1 if start_point == adapters.length - 1
    return nb_of_paths_from[start_point] if nb_of_paths_from.has_key?(start_point)
    nb_of_paths = 0
    ((start_point + 1)..(adapters.length - 1)).each do |i|
      if adapters[i] - adapters[start_point] <= 3
        nb_of_paths += count_paths_to_end_point(i)
      end
    end
    nb_of_paths_from[start_point] = nb_of_paths
  end
end

adapters = File.readlines('input.txt').map(&:to_i)

one_diff = 0
three_diff = 0
adapters << 0 << adapters.max + 3
adapters.sort!
adapters.each_cons(2) do |a1, a2|
  one_diff += 1 if a1 + 1 == a2
  three_diff += 1 if a1 + 3 == a2
end

puts one_diff * three_diff
dp = DynamicProgramming.new(adapters, {})
puts dp.count_paths_to_end_point(0)
