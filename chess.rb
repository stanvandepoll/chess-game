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
    # ["\u265C", "\u265E", "\u265D", "\u265B", "\u265A", "\u265D", "\u265E", "\u265C"]
    @matrix = [["\u265C", " ", " ", " ", "\u265A", " ", " ", "\u265C"],
               Array.new(8, "\u2659"),
               Array.new(8, " "),
               Array.new(8, " "),
               Array.new(8, " "),
               Array.new(8, " "),
               Array.new(8, "\u265F"),
               ["\u2656", " ", "\u2657", "\u2655", "\u2654", "\u2657", "\u2658", "\u2656"]]
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

  def castling(start, destination, board)
    unless King.path_blocked?(start, destination, board)
      puts "We are trying to castle!"
      if destination[1] > start[1] && start == [7,4] && Rook.castling_positions([7,7])
        remove_piece([7,4])
        place_piece([7,6], "white", :king)
        remove_piece([7,7])
        place_piece([7,5], "white", :rook)
        return true
      elsif destination[1] < start[1] && start == [7,4] && 
            Rook.castling_positions([7,0]) && @matrix[7][1] == " "
        remove_piece([7,4])
        place_piece([7,2], "white", :king)
        remove_piece([7,0])
        place_piece([7,3], "white", :rook)
        return true
      elsif destination[1] > start[1] && start == [0,4] && Rook.castling_positions([0,7])
        remove_piece([0,4])
        place_piece([0,6], "black", :king)
        remove_piece([0,7])
        place_piece([0,5], "black", :rook)
        return true
      elsif destination[1] < start[1] && start == [0,4] && 
            Rook.castling_positions([0,0]) && @matrix[0][1] == " "
        remove_piece([0,4])
        place_piece([0,2], "black", :king)
        remove_piece([0,0])
        place_piece([0,3], "black", :rook)
        return true
      end
    end
    false
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
board.display
board.move([1,2], [0,2])
board.display
board.move([0,2], [3,2])
board.display
board.move([3,2], [5,4])
board.display
board.move([6,1], [7,1])
board.display
board.move([7,1], [5,2])
board.display