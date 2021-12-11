#!/usr/bin/env ruby

# Open file
input_file = "../input.txt"
puts("Reading file #{input_file}")
file = File.open(input_file)

# Read file
#data = file.read.split("\n").map { |line| line.split("").map { |x| x.to_i } }
data = file.read.split("\n").map { |line| line.split("") }
num_rows = data.length
num_cols = data.first.length

field = Array.new()
field[0] = Array.new(num_cols + 2) { "9" }
(1..num_rows).each do |i|
    field[i] = ["9"] + data[i - 1] + ["9"]
end
field[num_rows + 1] = Array.new(num_cols + 2) { "9" }

risk_sum = 0
(1..num_rows).each do |r|
    (1..num_cols).each do |c|
        point = field[r][c].to_i
        if point == 0
            risk_sum += 1
        else
            up = field[r - 1][c].to_i
            down = field[r + 1][c].to_i
            left = field[r][c - 1].to_i
            right = field[r][c + 1].to_i
            if (point < up) && (point < down) && (point < left) && (point < right)
                risk_sum += (point + 1)
            end
        end
    end
end

puts risk_sum