module King
  @@moved = {"white" => false, "black" => false}
  def self.move(start, destination, team, board)

    # castling
    if @@moved[team] == false && start[0] == destination[0] && (start[1] - destination[1]).abs == 2
        if board.castling(start, destination, board)
          @@moved[team] = true
          return nil
        end
    end

    unless King.move_allowed?(start, destination, board)
      puts "That move is not allowed by a king."  
      return nil
    end
    
    if board.matrix[destination[0]][destination[1]] != " "
      if board.matrix[destination[0]][destination[1]].teamcolor == board.matrix[start[0]][start[1]].teamcolor
        puts "One of your pieces is already on the destination tile."
      else 
        puts "You capture one of your opponents pieces!"
        board.remove_piece(start)
        board.place_piece(destination, team, :king)
      end
    else
      board.remove_piece(start)
      board.place_piece(destination, team, :king)
    end
    @@moved[team] = true
  end

  def self.move_allowed?(start, destination, board)
    if path_blocked?(start, destination, board)
      return false
    end
    ((start[0] - destination[0])**2 + (start[1] - destination[1])**2) < 3
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
end