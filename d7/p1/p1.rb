#!/usr/bin/env ruby

# Open file
input_file = "../input.txt"
puts("Reading file #{input_file}")
file = File.open(input_file)

# Read file
data = file.read.split(",").map { |n| n.to_i }.sort!()

result = data.sum()
position = nil

(data.first..data.last).each do |pos|
    current = data.sum { |n| (n - pos).abs }
    if current < result
        result = current
        position = pos
    end
end

puts("#{result} at position #{position}")