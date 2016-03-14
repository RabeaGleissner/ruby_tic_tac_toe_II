class HumanPlayer

  def initialize(mark)
    @mark = mark
  end

  def make_move(position, board)
    board.add_mark(3, @mark)
  end
end
