module Rook

  def self.move(start, destination, team, board)

    unless Rook.move_allowed?(start, destination)
      puts "That move is not allowed by a rook."  
      return nil
    end
    
    if board.matrix[destination[0]][destination[1]] != " "
      if board.matrix[destination[0]][destination[1]].teamcolor == board.matrix[start[0]][start[1]].teamcolor
        puts "One of your pieces is already on the destination tile."
      else 
        puts "You capture one of your opponents pieces!"
        board.remove_piece(start)
        board.place_piece(destination, team, :rook)
      end
    else
      board.remove_piece(start)
      board.place_piece(destination, team, :rook)
    end
  end

  def self.move_allowed?(start, destination)
    start[0] == destination[0] || start[1] == destination[1]
  end

end