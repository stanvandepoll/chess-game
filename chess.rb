# encoding: utf-8

require_relative "knight.rb"
require_relative "rook.rb"
require_relative "bishop.rb"
require_relative "queen.rb"
require_relative "king.rb"
require_relative "pawn.rb"
require_relative "board.rb"
require_relative "string.rb"

###############################################################################


board = Board.new
board.display

=begin 
Stil to do:
  - Alternating turns between players
  - Declaring a winner
  - Save the game using YAML
  - Check and checkmate
  - Control that king doesn't move through check during castling
  - Extract a parent module called Piece
  - Refactor code
=end

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