#!/usr/bin/env ruby

# Open file
input_file = "../input.txt"
puts("Reading file #{input_file}")
file = File.open(input_file)

# Read file
data = file.read.split("\n")

line_size = data[0].length
line_count = data.length
threshold = line_count.div(2)
one_counts = Array.new(line_size) { 0 }

data.each do | line |
    line.split('').each_with_index do | number, number_index |
        one_counts[number_index] += number.to_i
    end
end

gamma_string = epsilon_string = ""
one_counts.each do | count |
    if count < threshold
        gamma_string += "0"
        epsilon_string += "1"
    else
        gamma_string += "1"
        epsilon_string += "0"
    end
end

gamma = gamma_string.to_i(2)
epsilon = epsilon_string.to_i(2)

puts("gamma: #{gamma}, epsilon: #{epsilon}\nResult = #{gamma * epsilon}")