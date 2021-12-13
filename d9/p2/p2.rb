#!/usr/bin/env ruby
require 'set'

# Open file
input_file = "../sample.txt"
puts("Reading file #{input_file}")
file = File.open(input_file)

# Read file
#data = file.read.split("\n").map { |line| line.split("").map { |x| x.to_i } }
data = file.read.split("\n").map { |line| line.split("") }
num_rows = data.length
num_cols = data.first.length

field = Array.new()
field[0] = Array.new(num_cols + 2) { 0 }
(1..num_rows).each do |i|
    field[i] = [0] + data[i - 1] + [0]
end
field[num_rows + 1] = Array.new(num_cols + 2) { 0 }

# "9"s are background, anything else is foreground
BACKGROUND = 0
FOREGROUND = 1
(1..num_rows).each do |r|
    (1..num_cols).each do |c|
        if field[r][c] == "9"
            field[r][c] = BACKGROUND
        else
            field[r][c] = FOREGROUND
        end
    end
end

field.each { |l| puts l.join() }

# connected components algorithm from wikipedia https://en.wikipedia.org/wiki/Connected-component_labeling
linked = Array.new(10) { Set.new() }
labels = Array.new(num_rows + 2) { Array.new(num_cols + 2) { BACKGROUND } }
next_label = 1
labels.each { |l| puts l.join() }

#     First pass
  
(1..num_rows).each do |r|
    (1..num_cols).each do |c|
        current_val = field[r][c]
        neighbor_vals = []
        if current_val != BACKGROUND
            up = field[r - 1][c]
            neighbor_vals << up if up == current_val
            left = field[r][c - 1]
            neighbor_vals << left if left == current_val
            puts current_val
            puts neighbor_vals.length
            if neighbor_vals.empty?
                linked[next_label].add(next_label)
                labels[r][c] = next_label
                next_label += 1
            else
                neighbor_vals.sort!()
                labels[r][c] = neighbor_vals.first
                neighbor_vals.each do |l|
                    linked[l] = linked[l].union(neighbor_vals)
                end
            end
        end
        puts linked
    end
end


labels.each { |l| puts l.join() }

#     Second pass
  
#     for row in data do
#         for column in row do
#             if data[row][column] is not Background then
#                 labels[row][column] = find(labels[row][column])
  
#     return labels
