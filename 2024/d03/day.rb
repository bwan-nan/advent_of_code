input = File.read('input.txt').strip()

p1 = input.scan(/mul\(\d+,\d+\)/).sum do |match|
  match.scan(/\d+/).map(&:to_i).inject(:*)
end

p p1
mul_enabled = true


p2 = input.scan(/do\(\)|don't\(\)|mul\(\d+,\d+\)/).sum do |match|
  case match
  when "do()"
    mul_enabled = true
    0
  when "don't()"
    mul_enabled = false
    0
  else
    if mul_enabled
      match.scan(/\d+/).map(&:to_i).inject(:*)
    else
      0
    end
  end
end

p p2
