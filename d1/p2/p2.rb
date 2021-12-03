#!/usr/bin/env ruby

# Open file
input_file = "../input.txt"
puts("Reading file #{input_file}")
file = File.open(input_file)

# Read file
data = file.read

# Split contents into an array
# and convert elements to ints
data_array = data.split.map { |x| x.to_i }

# Iterate over array, counting adjacent increases
# Don't forget to convert strings to ints!!!!
count = 0
prior = 999_999_999 # arbitrary really big value
current = 0

data_array.each_index do |i|
    current = data_array.slice(i, 3).sum

    if current > prior
        count += 1
    end

    prior = current
end

puts count
