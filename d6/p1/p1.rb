#!/usr/bin/env ruby

# Open file
input_file = "../input.txt"
puts("Reading file #{input_file}")
file = File.open(input_file)

# Read file
data = file.read.split(",")
school = data.map { |n| n.to_i }
days = 80

(1..days).each do |d|
    noobs = []
    school.each_with_index do |f, index|
        if f > 0
            school[index] = f - 1
        else
            school[index] = 6
            noobs << 8
        end
    end
    school += noobs
    puts("#{school.length} after #{d} days")
end