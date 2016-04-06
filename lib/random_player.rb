require 'marks'

class RandomPlayer
  include Marks
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def make_move(board)
    board.add_mark(random_position(board), mark)
  end

  def random_position(board)
    board.available_positions.sample
  end

  def ready?
    true
  end
end
