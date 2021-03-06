class PlayerWithPresetData
  attr_reader :mark, :moves

  def initialize(mark, moves = [])
    @mark = mark
    @moves = moves
  end

  def add_move(move)
    @moves << move
  end

  def make_move(board)
    board.add_mark(moves.shift, mark)
  end

  def ready?
    true
  end
end
