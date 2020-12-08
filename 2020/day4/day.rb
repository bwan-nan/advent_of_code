require 'ap'

REQUIRED_FIELDS = [
  'byr', # (Birth Year)
  'iyr', # (Issue Year)
  'eyr', # (Expiration Year)
  'hgt', # (Height)
  'hcl', # (Hair Color)
  'ecl', # (Eye Color)
  'pid', # (Passport ID)
  #'cid' # (Country ID)
]

####
# PART 2
###
def part_2(passports)
  valid = passports.map do |passport|
    required = (REQUIRED_FIELDS - passport.keys).empty?
    required && valid?(passport)
  end
  valid.select {|v| v == true }.count
end

def height_valid?(height)
  measure = height.split(//).last(2).join('')
  if measure == 'cm'
    return height.to_i.between?(150, 193)
  elsif measure == 'in'
    return height.to_i.between?(59, 76)
  end
  false
end

def pid_valid?(pid)
  !pid.match(/\A[0-9]{9}\z/).nil?
end

def eye_color_valid?(ecl)
  ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'].detect {|v| v == ecl}
end

def hair_color_valid?(hcl)
  return false unless hcl[0] == '#'
  hcl[0] = ''
  !hcl.match(/\A[a-fA-F0-9]*\z/).nil?
end

def valid?(passport)
  passport['byr'].to_i.between?(1920, 2002) \
    && passport['iyr'].to_i.between?(2010, 2020) \
    && passport['eyr'].to_i.between?(2020, 2030) \
    && height_valid?(passport['hgt']) \
    && hair_color_valid?(passport['hcl']) \
    && eye_color_valid?(passport['ecl']) \
    && pid_valid?(passport['pid']) 
end

####
# PART 1
####
def part_1(passports)
  valid = passports.map do |passport|
    (REQUIRED_FIELDS - passport.keys).empty?
  end
  valid.select {|v| v == true }.count
end

####
# Parsing
####
inputs = File.readlines('input.txt').map(&:strip!)
inputs << ''

passports = []
p = []

inputs.each_with_index do |line, i|
  if line == ''
    passports << p
    p = []
  else
    p << line
  end
end

#ap passports

passports = passports.map do |passport|
  p = passport.join(' ').split(' ')
  passport_fields = {}
  p.each do |line|
    k, v = line.split(':')
    passport_fields[k] = v
  end
  passport_fields
end

puts part_1(passports)
puts part_2(passports)

