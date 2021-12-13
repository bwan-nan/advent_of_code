lines = File.readlines('input.txt').map {|line| line.strip!}

x, y = [0, 0]
lines.map do |line|
  direction, value = line.split(' ')
  case direction
  when 'forward' then x += value.to_i
  when 'down' then y += value.to_i
  when 'up' then y -= value.to_i
  end
end

puts x * y

x, y, aim = [0, 0, 0]
lines.map do |line|
  direction, value = line.split(' ')
  case direction
  when 'forward'
    x += value.to_i
    y += aim * value.to_i
  when 'down' then aim += value.to_i
  when 'up' then aim -= value.to_i
  end
end

puts x * y
