#!/usr/bin/env ruby

class Cell
    attr_reader :value, :flashed, :x, :y

    def initialize(val, x, y)
        @value = val
        @x = x
        @y = y
        @flashed = false
    end

    def flashed?()
        @flashed
    end

    def clear()
        @flashed = false
    end

    def charge()
        @value += 1
        if @value > 9
            @flashed = true
            @value = 0
        end
    end

    def to_s()
        color_code = self.flashed? ? 31 : 32
        "\e[#{color_code}m#{@value}\e[0m"
    end
end

def display(field)
    field.each do |l|
        puts l.join("")
    end
end

def clear(field)
    field.each { |r| r.each { |c| c.clear } }
end

def process_field(field)
    flashes = 0
    field.each_with_index do |row, i|
        row.each_with_index do |cell, j|
            cell.charge()
            if cell.flashed?
                flashes += 1
                #find neighbors
                #send neighbor list to new fct?
                puts("#{i},#{j} flashed")
            end
        end
    end
    return flashes
end

def process_cell()
end
# Open file
input_file = "../sample.txt"
puts("Reading file #{input_file}")
file = File.open(input_file)

# Read file
data = file.read.split("\n").map { |line| line.split("") }
num_rows = data.length
num_cols = data.first.length

field = Array.new(num_rows)
(0..num_rows - 1).each do |r|
    field[r] = Array.new(num_cols)
    (0..num_cols - 1).each do |c|
        field[r][c] = Cell.new(data[r][c].to_i, r, c)
    end
end



max_steps = 2
flash_total = 0
(1..max_steps).each do |s|
    clear(field)
    flash_total += process_field(field)
    puts("After step #{s}:")
    display(field)
    puts("Total flashes: #{flash_total}")
end