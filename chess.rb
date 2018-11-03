# encoding: utf-8

class Knight
  attr_reader :team, :symbol
  attr_accessor :position
  def initialize(position, team, boardname)
    @position = position
    @team = team
    @symbol = :knight
    boardname.place_piece(@position, @team, @symbol)
  end

  def move(start, destination, board)
    unless move_allowed?(start, destination)
      puts "That move is not allowed by a knight."  
      return nil
    end
    if start != @position
      puts "Your knight is not on that position, so we can't move it."
    elsif board.matrix[destination[0]][destination[1]] != " "
      if board.matrix[destination[0]][destination[1]].teamcolor == board.matrix[start[0]][start[1]].teamcolor
        puts "One of your pieces is already on the destination tile."
      else 
        puts "You capture one of your opponents pieces!"
        board.capture_piece(destination)
        @position = destination
        board.remove_piece(start)
        board.place_piece(@position, @team, self.symbol)
      end
    else
      @position = destination
      board.remove_piece(start)
      board.place_piece(@position, @team, self.symbol)
    end
  end

  def move_allowed?(start, destination)
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

  def capture_piece(position)
    # this seems difficult to get right. How can I find the correct object instance 
    # just from the position and the symbol? Decided to freeze the idea of creating a new
    # class instance for every game piece. Play from manipulating the board instead.
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
knight1 = Knight.new([7,1], "white", board)
knight2 = Knight.new([5,2], "black", board)
board.display()
knight2.move([5,2], [7,1], board)
board.display()
puts "#{knight1.position}"
knight1.move([7,1], [5,2], board)
board.display()

