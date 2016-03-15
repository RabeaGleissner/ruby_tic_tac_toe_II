class PlayerWithPresetData
  attr_reader :mark, :moves, :replay

  def initialize(mark, moves, replay)
    @mark = mark
    @moves = moves
    @replay = replay
  end

  def make_move(board)
    board.add_mark(moves.shift, mark)
  end

  def play_again?
    replay.shift
  end

end
