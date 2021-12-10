#!/usr/bin/env ruby

# Open file
input_file = "../input.txt"
puts("Reading file #{input_file}")
file = File.open(input_file)

# Read file
data = file.read.split("\n")

right_side = data.map { |line| line.split(" | ").last }

display_hash = { 1 => 2, 4 => 4, 7 => 3, 8 => 7 }
count = 0

right_side.each do | line |
    line.split().each do |val|
        if display_hash.values.include?(val.length)
            count += 1
        end
    end
end

puts count