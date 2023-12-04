cards = File.readlines('input.txt').map {|l| l.strip.split(":")}
acc = Hash.new{|h,k| h[k]=0}

p1 = cards.map.with_index do |(card_number, numbers), i|
  acc[i] += 1
  winning_numbers, my_numbers = numbers.split("|").map {|l| l.strip.split(" ").map(&:to_i)}
  matches = (winning_numbers & my_numbers).count

  matches.times do |j|
    acc[i + 1 + j] += acc[i]
  end
  matches > 0 ? 2 ** (matches - 1) : 0
end.sum

puts p1
puts acc.values.sum
