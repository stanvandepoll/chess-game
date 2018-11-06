module Rook
  @@castling_positions = {[0,0] => true, [0,7] => true, 
                          [7,0] => true, [7,7] => true}

  def self.castling_positions(pos)
    @@castling_positions[pos]
  end
  
  def self.move(start, destination, team, board)

    unless Rook.move_allowed?(start, destination, board)
      puts "That move is not allowed by a rook."  
      return nil
    end
    
    if board.matrix[destination[0]][destination[1]] != " "
      if board.matrix[destination[0]][destination[1]].teamcolor == board.matrix[start[0]][start[1]].teamcolor
        puts "One of your pieces is already on the destination tile."
        return nil
      else 
        puts "You capture one of your opponents pieces!"
        board.remove_piece(start)
        board.place_piece(destination, team, :rook)
        castling_check(start)
      end
    else
      board.remove_piece(start)
      board.place_piece(destination, team, :rook)
      castling_check(start)
    end
    Pawn.remove_passant
  end

  private
  def self.move_allowed?(start, destination, board)
    (return false) if path_blocked?(start, destination, board)
    start[0] == destination[0] || start[1] == destination[1]
  end

  def self.path_blocked?(start, destination, board)
    # calculate a direction vector first, based on start and destination.
    # Then iterate, stepping through the path and checking whether any 
    # piece is in the way. values of vector can only be -1, 0 and 1.
    vector = [(destination[0] <=> start[0]), (destination[1] <=> start[1])]
    position = start
    until position == [destination, vector].transpose.map {|x| x.reduce(:-)} do 
      position = [position, vector].transpose.map(&:sum)
      if board.matrix[position[0]][position[1]] != " "
        return true
      end
    end
    false
  end

  def self.castling_check(start)
    if @@castling_positions.keys.include?(start)
      @@castling_positions[start] = false
    end
  end
end