#!/usr/bin/env ruby

# Open file
input_file = "../input.txt"
puts("Reading file #{input_file}")
file = File.open(input_file)

# Read file
data = file.read.split("\n")

# initialize array to hold counts
points = Array.new(1000) { Array.new(1000, 0) }

data.each do |line|
    puts("Processing #{line}")
    x1, y1 = line.split(" ").first.split(",").map { |n| n.to_i }
    x2, y2 = line.split(" ").last.split(",").map { |n| n.to_i }
    xs = [x1, x2].sort
    ys = [y1, y2].sort

    if (x1 == x2) || (y1 == y2)
        puts("Marking...")
        (xs.first..xs.last).each do |x|
            (ys.first..ys.last).each do |y|
                points[y][x] += 1
            end
        end
    end
end

overlap = 0
points.each do |row|
    #puts row.join("")
    row.each do |point|
        if point > 1
            overlap += 1
        end
    end
end

puts overlap