class Knight
  attr_reader :position, :team
  def initialize(start_position, team)
    @position = start_position
    @team = team
    chessboard.place_piece(@position, @team, knight)
  end

  def move(start, destination)
    unless move_allowed?(start, destination)
      puts "That move is not allowed by a knight."  
      return nil
    end
    if start != @position
      puts "Your knight is not on that position, so we can't move it."
    elsif chessboard.matrix[destination] != " "
      if chessboard.matrix[destination].teamcolor?(@team) 
        puts "One of your pieces is already on the destination tile."
      else 
        puts "You capture one of your opponents pieces!"
        chessboard.capture_piece(destination)
        @position = destination
        chessboard.remove_piece(start)
        chessboard.place_piece(@position, @team, knight)
      end
    else
      @position = destination
      chessboard.remove_piece(start)
      chessboard.place_piece(@position, @team, knight)
    end
  end

  def move_allowed?(start, destination)

  end

end

###############################################################################

class Board
  attr_reader :matrix
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
    # not sure whether this works
    # use a hash for both teams that give the correct string for the type
    @matrix[position] = string
  end

  def remove_piece(position)

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

chessboard = Board.new
chessboard.display()