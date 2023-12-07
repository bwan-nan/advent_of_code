file = "input.txt"
times, distances = []

times, distances = File.readlines(file).map do |l|
  l.strip.split(":").last.split(" ").map(&:to_i)
end

t2, d2 = File.readlines(file).map do |l|
  l.strip.split(":").last.gsub(/\s+/, "").to_i
end

times << t2
distances << d2

p1 = times.map.with_index do |time, i|
  (1..time).map do |t|
    t * (time - t)
  end.select{|n| n > distances[i]}.count
end
p2 = p1.pop
puts p1.inject(:*)
puts p2
