$sizes = {}

def total_size(h, pwd)
  size = h.dig(*pwd).sum do |k,v|
    if v.class == Hash
      total_size(h, pwd + [k])
    else
      v
    end
  end
  $sizes[pwd] = size
end

lines = File.readlines('input.txt').map(&:strip)

h = Hash.new { |h, k| h[k] = Hash.new(&h.default_proc) }
current_instruction = nil
pwd = []
lines.map do |line|
  if line[0] == '$'
    dol, instruction, dir = line.split(' ')
    current_instruction = instruction
    dir == '..' ? pwd.pop : pwd.append(dir) if instruction == 'cd'
  elsif current_instruction == 'ls'
    dir_or_size, name = line.split(' ')
    h.dig(*pwd)&.[]=(name, dir_or_size.to_i) if dir_or_size != 'dir'
  end
end

total_size(h, ['/'])
p $sizes.select {|k, v| v if v <= 100000}.sum {|k, v| v}

unused_space = 70000000 - $sizes[['/']]
needed_space = 30000000 - unused_space
p $sizes.sort_by {|k, v| v}.to_h.detect {|k, v| v >= needed_space}[1]
