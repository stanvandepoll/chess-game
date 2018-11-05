# encoding: utf-8

require_relative "knight.rb"
require_relative "rook.rb"
require_relative "bishop.rb"
require_relative "queen.rb"
require_relative "king.rb"
require_relative "pawn.rb"

###############################################################################

class Board
  attr_accessor :matrix
  @@symbol_hash_white = {king: "\u2654", queen: "\u2655", rook: "\u2656", bishop: "\u2657", knight: "\u2658", pawn: "\u2659"}
  @@symbol_hash_black = {king: "\u265A", queen: "\u265B", rook: "\u265C", bishop: "\u265D", knight: "\u265E", pawn: "\u265F"}

  def initialize
    # @matrix = Array.new(8){ Array.new(8, " ") }
    @matrix = [["\u265C", "\u265E", "\u265D", "\u265B", "\u265A", "\u265D", "\u265E", "\u265C"],
               Array.new(8, "\u265F"),
               Array.new(8, " "),
               Array.new(8, " "),
               Array.new(8, " "),
               Array.new(8, " "),
               Array.new(8, "\u2659"),
               ["\u2656", "\u2658", "\u2657", "\u2655", "\u2654", "\u2657", "\u2658", "\u2656"]]
  end

  def display
    puts "-----------------------------"
    0.upto(7) do |i|
    puts "#{@matrix[i].join(" | ")}"
    puts "-----------------------------"
    end
  end

  def move(start, destination)
    if @matrix[start[0]][start[1]] == " "
      puts "there is no piece at that position" 
      return
    end
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
board.display()
