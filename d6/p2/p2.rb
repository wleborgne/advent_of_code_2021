#!/usr/bin/env ruby

# Open file
input_file = "../input.txt"
puts("Reading file #{input_file}")
file = File.open(input_file)

# Read file
data = file.read.split(",").map { |n| n.to_i }

days = 256
initial_state = Hash.new{0}

(0..8).each do |t|
    initial_state[t] = data.count(t)
end
puts initial_state

(1..days).each do |d|
    noobs = resets = initial_state[0]
    initial_state[0] = initial_state[1]
    initial_state[1] = initial_state[2]
    initial_state[2] = initial_state[3]
    initial_state[3] = initial_state[4]
    initial_state[4] = initial_state[5]
    initial_state[5] = initial_state[6]
    initial_state[6] = initial_state[7] + resets
    initial_state[7] = initial_state[8]
    initial_state[8] = noobs
end
total = initial_state.values().sum()

puts total