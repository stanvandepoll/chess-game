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
      if chessboard.matrix[destination].teamcolor?(@team)) 
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

chessboard = Board.new

class Board
  def initialize

  end

  def place_piece(position, team, type)

  end

  def remove_piece(position)

  end 

  def capture_piece(position)

  end
end

class Game
  def teamcolor?(team)
    # use self and turn out true in case self is from the given team
  end
end