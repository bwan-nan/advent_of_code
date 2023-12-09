def add_number_to_array(number, array, part)
  if part == "part1"
    array.append(number)
  else
    array.prepend(number)
  end
end

def compute_result(history, part)
  if part == "part1"
    history.sum {|h| h[-1][-1]}
  else
    history.sum {|h| h[-1][0]}
  end
end

def run(lines, part)
  history = lines.map do |line|
    history = [line.each_cons(2).map {|a, b| b - a}, line]
    while history[0].uniq != [0]
      history.prepend(history.first.each_cons(2).map {|a, b| b - a})
    end
    add_number_to_array(0, history.first, part)

    len = history.size
    history.map.with_index do |h, i|
      break if i == len - 1
      number = part == "part1" ? \
        h[-1] + history[i + 1][-1] : history[i + 1][0] - h[0]
      add_number_to_array(number, history[i + 1], part)
    end
    history
  end
  compute_result(history, part)
end

lines = File.readlines('input.txt').map{|l| l.split(/\s+/).map(&:to_i)}

puts run(lines, "part1")
puts run(lines, "part2")
