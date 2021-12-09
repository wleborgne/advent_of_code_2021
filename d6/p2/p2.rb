#!/usr/bin/env ruby

# Open file
input_file = "../sample.txt"
puts("Reading file #{input_file}")
file = File.open(input_file)

# Read file
data = file.read.split(",")
days = 256
sim_results = []

(0..6).each do |initial|
    sim_school = [initial]
    (1..days).each do |d|
        noobs = []
        sim_school.each_with_index do |f, index|
            if f > 0
                sim_school[index] = f - 1
            else
                sim_school[index] = 6
                noobs << 8
            end
        end
        sim_school += noobs
        puts("#{sim_school.length} after #{d} days")
    end
    sim_results[initial] = sim_school.length
end

total = 0
data.each do |x|
    total += sim_results[x.to_i]
end
puts total