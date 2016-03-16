class ComputerPlayer
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def make_move(board)
    board.add_mark(board.available_positions.first, mark)
  end

  def score(board)
    score = -100
    if board.winner == mark
      score = 10
    elsif board.winner == false
      score = 0
    else
      score = -10
    end
    score
  end

  def switch_mark(mark)
    mark = mark == :X ? :O : :X
  end
end
