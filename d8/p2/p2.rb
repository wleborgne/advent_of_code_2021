#!/usr/bin/env ruby
require 'set'

# Open file
input_file = "../input.txt"
puts("Reading file #{input_file}")
file = File.open(input_file)

# Read file
data = file.read.split("\n")

# determine all possible connection schemes for 7-segment display
# Seven segment display:
#  000
# 1   2
# 1   2
# 1   2
#  333
# 4   5
# 4   5
# 4   5
#  666
# 
# Digit     Segments   Seg count
#   0       012456       6
#  *1       25           2
#   2       02346        5
#   3       02356        5
#  *4       1235         4
#   5       01356        5
#   6       013456       6
#  *7       025          3
#  *8       0123456      7
#   9       012356       6
# For each line, find combos which contain the "known" patterns
#
# 1 = 2 segs, unique
# 7 = 3 segs, unique
# 4 = 4 segs, unique
# 2 = 5 segs
# 3 = 5 segs, 3 segs same as 7 (proper subset), plus 2 segs
# 5 = 5 segs, proper subset of 6
# 6 = 6 segs, 7 is not a proper subset
# 0 = 6 segs, 7 is a proper subset, 4 is not a proper subset
# 9 = 6 segs, 7 and 4 are proper subsets
# 8 = 7 segs, unique

total = 0
data.each do |line|
    # prep for translation
    translation = Hash.new()
    left, right = line.split(" | ")
    right = right.split().map { |t| Set.new(t.split("")) }
    left = left.split().map { |t| Set.new(t.split("")) }

    # Unique cases
    translation["1"] = left.select { |s| s.length == 2 }.first
    translation["4"] = left.select { |s| s.length == 4 }.first
    translation["7"] = left.select { |s| s.length == 3 }.first
    translation["8"] = left.select { |s| s.length == 7 }.first

    # More complex cases
    translation["3"] = left.select { |s| (s.length == 5) && (translation["7"] < s)}.first # 5 segs and 7 is proper subset
    translation["6"] = left.select { |s| (s.length == 6) && !(translation["7"] < s)}.first # 6 segs and 7 is not a proper subset
    translation["9"] = left.select { |s| (s.length == 6) && (translation["7"] < s) && (translation["4"] < s)}.first # 6 segs and both 7 and 4 are proper subsets
    translation["0"] = left.select { |s| (s.length == 6) && (translation["7"] < s) && !(translation["4"] < s)}.first # 6 segs, 7 is proper subset, 4 is not
    translation["5"] = left.select { |s| (s.length == 5) && ( s < translation["6"])}.first # 5 segs, is a proper subset of 6
    translation["2"] = left.select { |s| (s.length == 5) && !(s == translation["3"]) && !(s == translation["5"]) }.first # 5 segs, not 3 or 5

    inverse = translation.invert()
    result = right.map { |digit| inverse[digit] }.join().to_i
    puts result
    total += result
end
puts total

