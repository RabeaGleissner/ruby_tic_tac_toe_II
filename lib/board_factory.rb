require 'board'

class BoardFactory
  def create_board(size)
    Board.new(size)
  end
end
