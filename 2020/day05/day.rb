require 'ap'

# FBFBBFFRLR
# Translated to binary: row=0101100; col=101
# binary 0101100 is 32+8+4=44
# binary 101 is 4+1=5

Seat = Struct.new(:row, :column) do
  def id
    @id ||= self.row * 8 + self.column
  end

end

inputs = File.readlines('input.txt').map {|line| line.strip!}

seats = []
inputs.map do |input|
  row = []
  col = []
  input.chars.each do |c|
    case c
    when 'F'
      row << '0'
    when 'B'
      row << '1'
    when 'L'
      col << '0'
    when 'R'
      col << '1'
    end
  end
  seats << Seat.new(row.join('').to_i(2), col.join('').to_i(2))
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

adjacent_ids = adjacent_seats.map(&:id)
puts adjacent_ids.min + 1
