# encoding: utf-8

module Knight

  def self.move(start, destination, team, board)

    unless Knight.move_allowed?(start, destination)
      puts "That move is not allowed by a knight."  
      return nil
    end
    
    if board.matrix[destination[0]][destination[1]] != " "
      if board.matrix[destination[0]][destination[1]].teamcolor == board.matrix[start[0]][start[1]].teamcolor
        puts "One of your pieces is already on the destination tile."
      else 
        puts "You capture one of your opponents pieces!"
        board.remove_piece(start)
        board.place_piece(destination, team, :knight)
      end
    else
      board.remove_piece(start)
      board.place_piece(destination, team, :knight)
    end
  end

  def self.move_allowed?(start, destination)
    (start[0] - destination[0])**2 + (start[1] - destination[1])**2 == 5
  end

end

###############################################################################

class Board
  attr_accessor :matrix
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
    if @matrix[start[0]][start[1]] == "\u2658"
      Knight.move(start, destination, "white", self)
    elsif @matrix[start[0]][start[1]] == "\u265E"
      Knight.move(start, destination, "black", self)
    end
  end

  def place_piece(position, team, type)
    if team == "white"
      symbol_hash = {king: "\u2654", queen: "\u2655", rook: "\u2656", bishop: "\u2657", knight: "\u2658", pawn: "\u2659"}
    elsif team == "black"
      symbol_hash = {king: "\u265A", queen: "\u265B", rook: "\u265C", bishop: "\u265D", knight: "\u265E", pawn: "\u265F"}
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
board.place_piece([5,2], "black", :knight)
board.display()
board.move([5,2], [7,1])
board.display()
board.move([7,1], [5,2])
board.display()

