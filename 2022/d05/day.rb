require 'set'

def solve(crates, instruction_list, part: 1)
  #crates.sort_by{|k, v| k}.map {|k, v| a ={:k => k, :v => v}; ap a}
  instruction_list.map do |instructions|
    nb, from, to = instructions.map(&:to_i)
    #puts "move #{nb} from #{from} to #{to}"
    to_move = crates[from].shift(nb)
    to_move.reverse! if part == 1
    crates[to].unshift(*to_move)
  end
  crates.sort_by {|k,v| k}.map {|k,v| v.first}.join
end

lines = File.readlines('input.txt')
crates = Hash.new{|h,k| h[k]=[]}
instruction_list = []
init = false

lines.map do |line|
  if init
    instruction_list << line.scan(/\d+/).to_a.map(&:to_i)
  else
    if line.strip.empty?
      init = true
    else
      letters = line.scan(/[A-Z]/)
      letters.uniq.map do |letter|
        indexes = (0..line.size).select {|j| line[j] == letter }
        indexes.map do |index|
          #index = 1 + 4 * (position - 1) 
          #index - 1 = 4 * (position - 1)
          #(index - 1) / 4  + 1 = position
          position = (index - 1) / 4 + 1
         # puts "#{letter} at  #{position}"
          crates[position] << letter
        end
      end
    end
  end
end

crates2 = crates.inject(Hash.new{|h,k| h[k]=[]}) {|acc, (k,v)| acc[k] = v.dup; acc}
puts solve(crates, instruction_list)
puts solve(crates2, instruction_list, part: 2)
