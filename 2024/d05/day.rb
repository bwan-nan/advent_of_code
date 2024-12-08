require 'set'

ordering_rules = Hash.new{|h,k| h[k]=Set.new}
sections = []
File.readlines('input.txt').map do |line|
  line.strip!

  if /\d+\|\d+/.match?(line)
    page_number, prior_to = line.split('|').map(&:to_i)
    ordering_rules[page_number] << prior_to
  end
  sections << line.split(',').map(&:to_i) if /^\d+(?:,\d+)*$/.match?(line)
end

def order_respected?(section, index, ordering_rules)
  page_number = section[index]
  section_rest = section.drop(index + 1)

  section_rest.all? do |prior_to|
    ordering_rules[page_number].include?(prior_to)
  end
end

sections_in_right_order, sections_in_wrong_order = sections.partition do |section|
  section.each_with_index.all? do |page_number, i|
    order_respected?(section, i, ordering_rules)
  end
end

p1 = sections_in_right_order.sum do |section|
  section[section.length / 2]
end

p p1

wrong_order_sections_reorded = sections_in_wrong_order.map do |section|
  section.sort {|a, b| ordering_rules[a].include?(b) ? -1 : 1}
end

p2 = wrong_order_sections_reorded.sum do |section|
  section[section.length / 2]
end

p p2
