require 'ap'

def median_values(array)
  len = array.count
  [ array[(len - 1) / 2], array[len / 2] ]
end

def partition(range, part)
  medians = median_values(range)
  if part == 'B' || part == 'R'
    range[range.index(medians[1])..-1]
  elsif part == 'F' || part == 'L'
    range[0..range.index(medians[0])]
  end
end

Seat = Struct.new(:row, :column) do
  def id
    @id ||= self.row * 8 + self.column
  end

end

inputs = File.readlines('input.txt').map {|line| line.strip!}

seats = []

inputs.map do |input|
  range = (0..127).to_a
  (0..6).each do |i|
    range = partition(range, input[i])
  end
  row = range.first
  range = (0..8).to_a
  (7..9).each do |i|
    range = partition(range, input[i])
  end
  column = range.first
  seats << Seat.new(row, column)
end

puts seats.max_by(&:id).id

adjacent_seats = seats.combination(2).detect do |s1, s2|
  # The seats with IDs +1 and -1 from yours will be in my list.
  # So there is a gap of 2 between these 2 IDs
  if s1.id == s2.id + 2 || s2.id == s1.id + 2
    min = [s1.id, s2.id].min
    seats.detect {|s| s.id == min + 1}.nil?
  end
end

# Returns the 2 IDs of the seats next to me
adjacent_ids = adjacent_seats.map(&:id)
puts adjacent_ids.min + 1

