require 'set'

class Day
  attr_reader :lines
  attr_accessor :numbers_adjacent_to_symbol, :n, :is_part_number, :gears, :gear_positions

  def initialize(input = "input.txt")
    @lines = File.readlines(input).map(&:strip)
    @numbers_adjacent_to_symbol = []
    @gears = Hash.new{|h,k| h[k]=Set.new}
  end

  def part1
    run
    numbers_adjacent_to_symbol.sum
  end

  def part2
    run
    gears.select {|k, v| v.count == 2}.sum {|k, v| v.inject(:*)}
  end

  def run
    @_run ||= exec_run
  end

  def exec_run
    lines.each_with_index do |line, j|
      reset_variables
      (line + ".").chars.each_with_index do |c, i|
        if is_digit?(c)
          @n = n * 10 + c.to_i
          check_if_part_number(i, j)
        else
          if is_part_number
            numbers_adjacent_to_symbol << n

            gear_positions.map do |gear_position|
              gears[gear_position] << n
            end
          end
          reset_variables
        end
      end
    end
  end

  def check_if_part_number(i, j)
    for x in [-1, 0, 1] do
      for y in [-1, 0, 1] do
        char = lines&.[](j + y)&.[](i + x)
        if is_symbol?(char)
          @is_part_number = true
        end
        @gear_positions << [j + y, i + x] if is_gear?(char)
      end
    end
  end

  private

  def is_gear?(char)
    char == "*"
  end

  def is_digit?(char)
    return false if char.nil?
    char.ord.between?('0'.ord, '9'.ord)
  end

  def is_symbol?(char)
    return false if char.nil?
    char != "." && !is_digit?(char)
  end

  def reset_variables
    @n = 0
    @is_part_number = false
    @gear_positions = Set.new
  end
end

d = Day.new
puts d.part1
puts d.part2
