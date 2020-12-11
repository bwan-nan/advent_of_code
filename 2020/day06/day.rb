require 'ap'

inputs = File.readlines('input.txt').map(&:strip!)
inputs << ''

group_answers = []
a = []

inputs.each_with_index do |line, i|
  if line == ''
    group_answers << a
    a = []
  else
    a << line
  end
end

group_uniq_answers = group_answers.map do |answer|
  answer.join('').chars.uniq.join('')
end

puts group_uniq_answers.inject(0) {|sum, g_answer| sum += g_answer.length}

everyone_said_yes_counts = group_uniq_answers.map.with_index do |g_answer, i|
  sum = 0
  nb_of_persons_in_group = group_answers[i].count
  g_answer.chars.uniq.each do |c|
    yes_count = group_answers[i].select {|answer| answer.include?(c)}.count
    sum += 1 if nb_of_persons_in_group == yes_count
  end
  sum
end

puts everyone_said_yes_counts.inject(&:+)

