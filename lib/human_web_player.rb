class HumanWebPlayer
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def add_move(position)
    @move = position.to_i
  end

  def make_move(board)
    new_board = board.add_mark(@move, mark)
    @move = nil
    new_board
  end

  def ready?
    @move != nil
  end
end
