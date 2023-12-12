input = File.readlines('input.txt')

p1 = input.map(&:chars).sum do |line|
  digits = line.select {|c| c.to_s.ord.between?('1'.ord, '9'.ord)}
  "#{digits[0]}#{digits[-1]}".to_i
end
puts p1

dict = {
  "one" => 1,
  "two" => 2,
  "three" => 3,
  "four" => 4,
  "five" => 5,
  "six" => 6,
  "seven" => 7,
  "eight" => 8,
  "nine" => 9
}

p2 = input.sum do |line|
  digits = line.chars.map.with_index do |c, i|
    l = line[i..-1]
    if l[0].to_s.ord.between?('1'.ord, '9'.ord)
      l[0].to_i
    else
      digit_in_letters = dict.keys.detect {|digit| l.to_s.start_with?(digit)}
      dict[digit_in_letters]
    end
  end.compact
  "#{digits[0]}#{digits[-1]}".to_i
end
puts p2
