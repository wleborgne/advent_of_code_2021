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
reverse_hash = symbol_hash.invert()
score_hash = { ")" => 1, "]" => 2, "}" => 3, ">" => 4 }

puts symbol_hash
puts score_hash

line_scores = []
data.each_with_index do |line, i|
    puts("Processing line #{i + 1}")
    corrupt = false
    line_stack = []
    line.split("") do |s|
        if openers.include?(s)
            line_stack.push(s)
        else
            last = line_stack.pop()
            if symbol_hash[s] != last
                puts("#{s} doesn't match #{last}; skipping line.")
                corrupt = true
            end
        end
    end
    next if corrupt
    puts line_stack.join("")
    line_score = 0
    line_stack.reverse.each do |c|
        line_score = (5 * line_score) + score_hash[reverse_hash[c]]
    end
    line_scores << line_score
    puts line_scores.join(", ")
end

line_scores.sort!()
middle = line_scores.length / 2
puts line_scores[middle]

