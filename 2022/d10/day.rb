lines = File.readlines('input.txt').map {|l| l.strip.split}

current_instruction = nil
duration, cycle_nb = 0, 0
signal_register = 1
signal_strengths = {}

def draw_pixel(crt_position, cycle_nb)
  draw = !(crt_position..(crt_position + 2)).detect do |p|
    p % 40 == cycle_nb % 40
  end.nil?
  draw ? (print '#') : (print '.')
  puts "\n" if cycle_nb % 40 == 0
end

lines.map do |instruction, value|
  case instruction
  when 'noop'
    current_instruction = instruction
    duration = 1
    while duration > 0
      cycle_nb += 1
      draw_pixel(signal_register, cycle_nb)
      signal_strengths[cycle_nb] = signal_register * cycle_nb if (cycle_nb + 20) % 40 == 0
      duration -= 1
    end
  when 'addx'
    current_instruction, value = instruction, value.to_i
    duration = 2
    while duration > 0
      cycle_nb += 1
      draw_pixel(signal_register, cycle_nb)
      signal_strengths[cycle_nb] = signal_register * cycle_nb if (cycle_nb + 20) % 40 == 0
      duration -= 1
    end
    signal_register += value
  end
end
puts "\n"
puts signal_strengths.values.sum
