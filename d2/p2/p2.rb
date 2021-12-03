#!/usr/bin/env ruby

# Open file
input_file = "../input.txt"
puts("Reading file #{input_file}")
file = File.open(input_file)

# Read file
data = file.read.split("\n")

# Initial position
position = {x: 0, y:0, aim: 0}

data.each do |command|
    direction, displacement = command.split
    displacement = displacement.to_i

    puts("Moving #{direction} #{displacement} units.")
    case direction
    when "forward"
        position[:x] += displacement
        position[:y] += position[:aim] * displacement
    when "down"
        position[:aim] += displacement
    when "up"
        position[:aim] -= displacement
    end
    puts("New position: x = #{position[:x]}, y = #{position[:y]}")
end

puts("Result: #{position[:x] * position[:y]}")