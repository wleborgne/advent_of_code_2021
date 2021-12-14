#!/usr/bin/env ruby

# Open file
input_file = "../input.txt"
puts("Reading file #{input_file}")
file = File.open(input_file)

# Read file
data = file.read.split("\n")

openers = ["(", "[", "{", "<"]
closers = [")", "]", "}", ">"]
symbol_hash = { ")" => "(", "]" => "[", "}" => "{", ">" => "<" }
score_hash = { ")" => 3, "]" => 57, "}" => 1197, ">" => 25137 }

puts symbol_hash
puts score_hash

running_score = 0
data.each_with_index do |line, i|
    puts("Processing line #{i + 1}")
    line_stack = []
    line.split("") do |s|
        if openers.include?(s)
            line_stack.push(s)
        else
            last = line_stack.pop()
            if symbol_hash[s] != last
                puts("#{s} doesn't match #{last}")
                running_score += score_hash[s]
                puts running_score
            end
        end
    end
end

puts running_score