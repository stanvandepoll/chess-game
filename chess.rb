# encoding: utf-8

require_relative "knight.rb"
require_relative "rook.rb"

###############################################################################

class Board
  attr_accessor :matrix
  @@symbol_hash_white = {king: "\u2654", queen: "\u2655", rook: "\u2656", bishop: "\u2657", knight: "\u2658", pawn: "\u2659"}
  @@symbol_hash_black = {king: "\u265A", queen: "\u265B", rook: "\u265C", bishop: "\u265D", knight: "\u265E", pawn: "\u265F"}

  def initialize
    @matrix = Array.new(8){ Array.new(8, " ") }
  end

  def display
    puts "-----------------------------"
    0.upto(7) do |i|
    puts "#{@matrix[i].join(" | ")}"
    puts "-----------------------------"
    end
  end

  def move(start, destination)
    @@symbol_hash_white.each_pair do |symbol, string|
      if @matrix[start[0]][start[1]] == string
        eval(symbol.to_s.capitalize).move(start, destination, "white", self)
      end
    end
    @@symbol_hash_black.each_pair do |symbol, string|
      if @matrix[start[0]][start[1]] == string
        eval(symbol.to_s.capitalize).move(start, destination, "black", self)
      end
    end
  end

  def place_piece(position, team, type)
    if team == "white"
      symbol_hash = @@symbol_hash_white
    elsif team == "black"
      symbol_hash = @@symbol_hash_black
    end
    symbol = symbol_hash[type]
    @matrix[position[0]][position[1]] = symbol
  end

  def remove_piece(position)
    @matrix[position[0]][position[1]] = " "
  end 

end

###############################################################################

class String
  def teamcolor
    if self == "\u2654" || self == "\u2655" || self == "\u2656" || self == "\u2657" || self == "\u2658" || self == "\u2659"
      "white"
    else
      "black"
    end
  end
end

board = Board.new
board.place_piece([7,1], "white", :knight)
board.place_piece([3,1], "black", :rook)
board.display()
board.move([3,1], [5,1])
board.display()
board.move([5,1], [7,1])
board.display()

