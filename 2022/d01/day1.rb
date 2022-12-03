input = File.readlines('input.txt')
i = 0 
h = input.inject(Hash.new{|h,k|h[k]=0}) do |acc, line|
  line.strip.empty? ? i += 1 : acc[i] += line.strip.to_i
  acc
end
p h.values.max
p h.sort_by {|k,v| -v}.first(3).sum{|k, v| v}

