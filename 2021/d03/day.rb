require 'ap'

class DiagnosticReport
  attr_accessor :bits_array

  def initialize(bits_array)
    @bits_array = bits_array
  end

  def part_1
    gamma.join.to_i(2) * epsilon.join.to_i(2)
  end

  def part_2
    oxygen_generator_rating = get_rating_for(:oxygen_generator_rating)
    co2_scrubber_rating = get_rating_for(:co2_scrubber_rating)
    oxygen_generator_rating * co2_scrubber_rating
  end

  protected

  def gamma
    @gamma ||= (0..(bits_size - 1)).map do |i|
      most_common_bit_at_index(i)
    end
  end

  def epsilon
    @epsilon ||= gamma.map {|bit| bit.to_i == 1 ? 0 : 1}
  end

  def get_rating_for(life_metric)
    numbers = bits_array.dup
    i = 0
    while bits_array[i % bits_size]
      break if numbers.count == 1
      mc = bit_criteria(i % bits_size, numbers, life_metric)
      numbers = numbers.select do |bits|
        bits[i].to_i == mc
      end
      i += 1
    end
    numbers.first.join.to_i(2)
  end

  def bit_criteria(index, array, life_metric = :oxygen_generator_rating)
    zero, one = bits_count_at_index(index, array)
    if life_metric == :oxygen_generator_rating
      one >= zero ? 1 : 0
    else
      one >= zero ? 0 : 1
    end
  end

  def bits_size
    bits_array.first.count
  end

  def bits_count_at_index(index, array)
    zero, one = [0, 0]
    array.each do |bits|
      bits[index].to_i == 1 ? one += 1 : zero += 1
    end
    [zero, one]
  end

  def most_common_bit_at_index(index, array = bits_array)
    zero, one = bits_count_at_index(index, array)
    one > zero ? 1 : 0
  end
end

bits_array = File.readlines('input.txt').map {|line| line.strip!.chars}


report = DiagnosticReport.new(bits_array)
puts report.part_1
puts report.part_2
