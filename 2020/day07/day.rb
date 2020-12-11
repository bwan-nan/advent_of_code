require 'ap'

Bag = Struct.new(:bag_type, :content) do
  def contains?(bag_type)
    self.content.detect {|b| b && b[:bag_type] == bag_type}
  end

  def open_content(bags)
    self.content.compact.map do |item|
      bag = bags.detect {|b| b.bag_type == item[:bag_type]}
      bag.content = bag.content.compact
      [item[:nb], bag]
    end
  end
end

def part_1(bags)
  target_bag_type = 'shiny gold'
  # Get bags that directly contain at least 1 shiny gold bag
  containers = bags.select {|b| b.contains?(target_bag_type)}
  # Put the bag_type of each of these bags in a queue
  queue = containers.map(&:bag_type)

  # While queue is not empty
  while queue.count > 0
    bag_type = queue.shift
    # Get bags that could contain this one
    new_containers = bags.select {|b| b.contains?(bag_type)}
    new_containers.each do |bag|
      # Only append to queue if bag not already in list of eventual "container" bags
      if containers.detect{|b| b.bag_type == bag.bag_type}.nil?
        queue << bag.bag_type 
        containers << bag
      end
    end
  end
  containers.flatten.count
end

def part_2(bags, bag)
  bag_content = bag.open_content(bags)
  return 0 if bag_content.empty?
  bag_content.inject(0) do |sum, item|
    nb, new_bag = item
    sum += nb * (1 + part_2(bags, new_bag))
    sum
  end
end

inputs = File.readlines('input.txt').map {|line| line.strip!}

bags = inputs.map.with_index do |input, i|
  k, v = input.split(' bags contain ')

  values = v.split(', ').map do |str|
    match = str.scan(/(\d|no) (.+)$/).first
    if match[0].match(/\A\d\z/) != nil
      {nb: match[0].to_i, bag_type: match[1].gsub(/ bags?.?/, '')}
    end
  end
  Bag.new(k, values)
end


puts part_1(bags)
my_bag = bags.detect{|b| b.bag_type == 'shiny gold'}
puts part_2(bags, my_bag)

