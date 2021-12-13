require 'ap'


list = File.readlines('input.txt').map {|l| l.strip!.split(',').map(&:to_i)}.first

def part_1(list)
  list_size = list.count

  (1..80).each do |day|
    stop = list_size
    i = 0
    while i < stop
      if list[i] == 0
        list[i] = 6
        list << 8
        list_size += 1
      else
        list[i] -= 1
      end
      i += 1
    end
  end
  list_size
end


def part_2(list)
  lanternfish_stock = init_stock(list)
  new_stock = nil
  (1..256).each do |day|
    new_stock = lanternfish_stock.dup
    lanternfish_stock.each_with_index do |lanternfish_count, i|
      if i == 0
        new_stock[i] = 0
        new_stock[6] += lanternfish_count
        new_stock[8] += lanternfish_count
      elsif lanternfish_count > 0
        new_stock[i] -= lanternfish_count
        new_stock[i - 1] += lanternfish_count
      end
    end
    lanternfish_stock = new_stock
  end
  lanternfish_stock.sum
end

def init_stock(list)
  lanternfish_stock = [0, 0, 0, 0, 0, 0, 0, 0, 0]
  list.map do |lanternfish|
    lanternfish_stock[lanternfish] += 1
  end
  lanternfish_stock
end


puts part_1(list)
puts part_2(list)


