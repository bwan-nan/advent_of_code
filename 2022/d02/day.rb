require 'ap'
class Player
  attr_reader :action
  def initialize(action)
    @action = action
  end

end

class Hero < Player
  def initialize(action)
    super
  end

  def normalized_action(options = {})
    @_normalized_action ||= compute_normalized_action(options[:part], options[:other_action])
  end

  def compute_normalized_action(part, other_action)
    return normalized_action_2(other_action) if part == 2
    case action
    when 'X' then 'A'
    when 'Y' then 'B'
    when 'Z' then 'C'
    end
  end

  def normalized_action_2(other_action)
    case action
    when 'X' then losing_action(other_action)
    when 'Y' then other_action
    when 'Z' then winning_action(other_action)
    end
  end

  def losing_action(other_action)
    case other_action
    when 'A' then 'C'
    when 'B' then 'A'
    when 'C' then 'B'
    end
  end

  def winning_action(other_action)
    case other_action
    when 'A' then 'B'
    when 'B' then 'C'
    when 'C' then 'A'
    end
  end
end
class Vilain < Player
  def initialize(action)
    super
  end

  def normalized_action
    action
  end
end

class Game
  attr_reader :p1, :p2, :part
  def initialize(p1, p2, part)
    @p1 = p1
    @p2 = p2
    @part = part
  end

  def hero_score
    action_score + round_score
  end

  def action_score
    case p2.normalized_action(part: part, other_action: p1.normalized_action)
    when 'A' then 1
    when 'B' then 2
    when 'C' then 3
    end
  end

  def round_score
    if winner == p1
      0
    elsif winner == p2
      6
    else
      3
    end
  end

  def winner
    @_winner ||= determine_winner
  end

  def determine_winner
    return [p1, p2] if actions.uniq.count == 1
    if p1.action == 'A'
      p2.normalized_action == 'B' ? p2 : p1
    elsif p1.action == 'B'
      p2.normalized_action == 'C' ? p2 : p1
    else
      p2.normalized_action == 'A' ? p2 : p1
    end
  end

  def actions
    [p1.action, p2.normalized_action]
  end
end

rounds = File.readlines('input.txt').map {|l| l.strip.split}
part1 = rounds.sum do |a, b|
  v, h = Vilain.new(a), Hero.new(b)
  Game.new(v, h, 1).hero_score
end

part2 = rounds.sum do |a, b|
  v, h = Vilain.new(a), Hero.new(b)
  Game.new(v, h, 2).hero_score
end

p part1
p part2
