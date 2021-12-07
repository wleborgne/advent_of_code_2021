#!/usr/bin/env ruby

class Cell
    attr_accessor :value
    attr_reader :x, :y

    def initialize(val, x, y)
        @value = val
        @x = x
        @y = y
        @marked = false
    end

    def marked?()
        @marked
    end

    def mark()
        @marked = true
    end

    def to_s()
        color_code = self.marked? ? 31 : 32
        "\e[#{color_code}m#{@value}\e[0m"
    end
end

class Board
    def initialize(lines)
        @cells = []
        (0..4).each do | row |
            lines[row].split(" ").each_with_index do | val, col |
                @cells << Cell.new(val.to_i, row, col)
            end
        end
    end

    def mark(val)
        if i = @cells.index { |c| c.value == val.to_i }
            puts("Marking cell for value #{val}")
            @cells[i].mark()
            puts self.to_s
        end
        self.wins?
    end

    def wins?()
        return false unless @cells.first.value >= 0
        wins = false
        (0..4).each do |i|
            row_result = @cells.select { |c| c.x == i }.all? { |c| c.marked? }
            column_result = @cells.select { |c| c.y == i }.all? { |c| c.marked? }
            wins = row_result || column_result
            break if wins
        end
        return wins
    end

    def result()
        @cells.reject { |c| c.marked? }.map { |c| c.value }.sum
    end

    def wipe()
        @cells.each { |c| c.value = -1 }
    end

    def to_s()
        #@cells.each { |c| c.to_s }.join(" ")
        s = ""
        @cells.each_with_index do |c, i|
            s += c.to_s
            if ((i + 1) % 5) == 0
                s += "\n"
            else
                s += " "
            end
        end
        return s + "\n"
    end
end

# Open file
input_file = "../input.txt"
puts("Reading file #{input_file}")
file = File.open(input_file)

# Read file
data = file.read.split("\n")

# Extract called numbers
numbers = data.shift.split(",")
data.shift # remove blank line
puts numbers

# Create boards
boards = []
while data.length >= 5
    boards << Board.new(data.shift(5))
    data.shift
end

puts("#{boards.length} boards: ")
puts boards.each { |b| b.to_s }

won_at = nil
numbers.each do |n|
    puts("Calling number: #{n}")
    boards.each_with_index do |b, i|
        mark_result = b.mark(n)
        if mark_result
            won_at = n.to_i
            puts("Board #{i} won at #{won_at} with result #{b.result() * won_at}")
            b.wipe
        end
    end
end

