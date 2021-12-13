require 'ap'
require 'set'

class Board
  attr_accessor :rows, :columns, :marked_numbers, :rank
  
  def initialize
    @rows = []
    @columns = []
    @marked_numbers = []
  end

  def won?
    @won ||= complete_row? || complete_column?
  end
  
  def complete_row?
    rows.detect do |row|
      Set.new(row).subset?(Set.new(marked_numbers))
    end
  end

  def complete_column?
    columns.detect do |column|
      Set.new(column).subset?(Set.new(marked_numbers))
    end
  end

  def unmarked_numbers
    rows.flatten - marked_numbers
  end

  def last_number_called
    marked_numbers.last
  end

  def mark_number(number)
    return if won?
    self.marked_numbers << number if rows.flatten.include?(number)
  end

  def add_row(numbers)
    rows << numbers
    complete_columns(numbers)
  end

  def complete_columns(numbers)
    numbers.each_with_index do |n, j|
      if columns[j].nil?
        self.columns[j] = [n]
      else
        self.columns[j] << n
      end
    end
  end
end


lines = File.readlines('input.txt').map {|line| line.strip!}
called_numbers = lines.shift.split(',').map(&:to_i)
lines = lines.map {|l| l.split(' ').map(&:to_i)}

boards = []
lines.each do |line|
  if line.empty?
    boards << Board.new
    next
  end
  boards.last.add_row(line)
end

rank = 0

define_method :part_1 do |boards|
  winning_board = nil
  called_numbers.map do |number|
    break if winning_board
    boards.map {|board| board.mark_number(number)}
    winning_board = boards.detect {|board| board.won?}
  end
  winning_board.unmarked_numbers.sum * winning_board.last_number_called
end

define_method :part_2 do |boards|
  called_numbers.map do |number|
    boards.map {|board| board.mark_number(number)}
    boards.map do |board|
      if board.won? && board.rank.nil?
        rank += 1
        board.rank = rank
      end
    end
    break if boards.select {|b| b.won?}.count == boards.count
  end
  last_winning_board = boards.max_by{|board| board.rank}
  last_winning_board.unmarked_numbers.sum * last_winning_board.last_number_called
end

puts part_1(boards)
puts part_2(boards)
