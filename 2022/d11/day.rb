class Day
  attr_accessor :monkey_packs, :part
  def initialize(part)
    @part = part
    @monkey_packs = []
    parse
  end

  def parse
    ops = File.read('input.txt').split("\n\n").map{|l| l.strip.split("\n")}
    ops.each_with_index do |mp, i|
      monkey_packs[i] = {inspect_count: 0}
      mp.map do |line|
        l = line.scan(/Starting items: (.*)/)
        monkey_packs[i][:items] = l[0][0].split(',').map(&:to_i) if l[0]
        l = line.scan(/Operation: new = old (\+|\*){1} (.+)/)
        monkey_packs[i][:op] = l[0][0] if l[0]
        monkey_packs[i][:val] = l[0][1] if l[0]
        l = line.scan(/Test: divisible by (\d+)/)
        monkey_packs[i][:divisible_by] = l[0][0].to_i if l[0]
        l = line.scan(/If true: throw to monkey (\d+)/)
        monkey_packs[i][:true] = l[0][0].to_i if l[0]
        l = line.scan(/If false: throw to monkey (\d+)/)
        monkey_packs[i][:false] = l[0][0].to_i if l[0]
      end
    end
  end

  def execute_operation(current_worry_level, operator, value)
    value = value == 'old' ? current_worry_level : value.to_i
    new_worry_level = current_worry_level.method(operator).(value)
    return new_worry_level % lcm if part == 2
    new_worry_level / 3
  end

  def solve
    (0...round_threshold).map do
      monkey_packs.map do |monkey|
        while worry_level = monkey[:items].shift
          monkey[:inspect_count] += 1
          new_worry_level = execute_operation(worry_level, monkey[:op], monkey[:val])
          throw_to_index = new_worry_level % monkey[:divisible_by] == 0 ? monkey[:true] : monkey[:false]
          monkey_packs[throw_to_index][:items].append(new_worry_level)
        end
      end
    end
    sorted_monkey_businesses = monkey_packs.sort_by {|monkey| monkey[:inspect_count]}
    sorted_monkey_businesses.last(2).map {|monkey| monkey[:inspect_count]}.inject(:*)
  end

  def round_threshold
    part == 2 ? 10_000 : 20
  end

  def lcm
    @_lcm ||= monkey_packs.map {|h| h[:divisible_by]}.reduce(1, :lcm)
  end
end

p Day.new(1).solve
p Day.new(2).solve
