class Knight
  attr_reader :position, :team, :symbol
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
      if board.matrix[destination[0]][destination[1]].teamcolor?(@team) 
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
    symbol_hash = {king: "K", queen: "Q", rook: "R", bishop: "B", knight: "N", pawn: "p"}
    symbol = symbol_hash[type]
    @matrix[position[0]][position[1]] = symbol
  end

  def remove_piece(position)
    @matrix[position[0]][position[1]] = " "
  end 

  def capture_piece(position)

  end
end

###############################################################################

class Game
  def teamcolor?(team)
    # use self and turn out true in case self is from the given team
  end
end

board = Board.new
board.display()
knight = Knight.new([7,1], "black", board)
board.display()
knight.move([7,1], [5,2], board)
board.display()
knight.move([5,2], [1,1], board)
board.display()
