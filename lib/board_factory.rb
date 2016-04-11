require 'board'

class BoardFactory
  BOARD_SIZES = { 1 => "3x3",
                  2 => "4x4" }

  def create_board(size)
    Board.new(size)
  end
end
