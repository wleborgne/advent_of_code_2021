#!/usr/bin/env ruby

# Open file
input_file = "input.txt"
puts("Reading file #{input_file}")
file = File.open(input_file)

# Read file
data = file.read

# Split contents into an array
data_array = data.split

# Iterate over array, counting adjacent increases
# Don't forget to convert strings to ints!!!!
count = 0
data_array.each_with_index do |item, index|
    next if index == 0
    if item.to_i > data_array[index - 1].to_i
        count += 1
    end
end

puts count
