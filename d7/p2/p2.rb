#!/usr/bin/env ruby

# Open file
input_file = "../input.txt"
puts("Reading file #{input_file}")
file = File.open(input_file)

# Read file
data = file.read.split(",").map { |n| n.to_i }.sort!()

result = 999_999_999
position = nil

(data.first..data.last).each do |pos|
    current = data.sum do |n|
        interval = (n - pos).abs
        (0..interval).sum()
    end
    if current < result
        result = current
        position = pos
    end
end

puts("#{result} at position #{position}")