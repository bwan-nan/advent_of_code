lines = File.readlines('sample.txt').map(&:strip) + [""]

seeds = lines.shift.split(":")[1].split(" ").map(&:to_i)

maps = []
map = []
lines.map do |line|
  next if line.include?("map:")
  if line.empty?
    maps << map if map.any?
    map = []
  else
    dest, source, range_length = line.split(" ").map(&:to_i)
    map << {
      source: source,
      dest: dest,
      range_length: range_length
    }
  end
end

seeds = seeds.each_slice(2).to_a.map {|a, b| (a..(a+b)).to_a}.flatten.uniq
res = maps.map do |map|
  seeds = seeds.map do |seed|
    dest = seed
    map.map do |m|
      if seed.between?(m[:source], m[:source] + m[:range_length] - 1)
        dest = m[:dest] + seed - m[:source]
        break
      end
    end
    dest
  end
end

puts res.last.min
