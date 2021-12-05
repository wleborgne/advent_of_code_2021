#!/usr/bin/env ruby

# count total '1's in each position 
def one_counter(data)
    one_counts = Array.new(data.first.size) { 0 }

    data.each do | line |
        line.split('').each_with_index do | number, number_index |
            one_counts[number_index] += number.to_i
        end
    end

    one_counts
end

# calculate o2 rating
def o2(data, position = 0)
    line_count = data.length
    threshold = line_count / 2.0
    
    one_count = one_counter(data)[position]
    keep = one_count >= threshold ? '1' : '0'

    filtered_data = data.filter { |element| element[position] == keep }

    if filtered_data.length == 1
        return filtered_data[0].to_i(2)
    else
        o2(filtered_data, position + 1)
    end
end

# calculate co2 rating
def co2(data, position = 0)
    line_count = data.length
    threshold = line_count / 2.0
    
    one_count = one_counter(data)[position]
    keep = one_count < threshold ? '1' : '0'

    filtered_data = data.filter { |element| element[position] == keep }

    if filtered_data.length == 1
        return filtered_data[0].to_i(2)
    else
        co2(filtered_data, position + 1)
    end
end

# Open file
input_file = "../input.txt"
puts("Reading file #{input_file}")
file = File.open(input_file)

# Read file
data = file.read.split("\n")

o2_rating = o2(data)

puts("O2 rating = #{o2_rating}")

co2_rating = co2(data)

puts("CO2 rating = #{co2_rating}")
puts("Results = #{o2_rating * co2_rating}")
