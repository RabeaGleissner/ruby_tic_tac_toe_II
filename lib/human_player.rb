require 'ui'
class HumanPlayer
  attr_reader :mark, :ui

  def initialize(mark, ui)
    @mark = mark
    @ui = ui
  end

  def ready?
    true
  end

  def make_move(board)
    board.add_mark(ui.request_position(board), mark)
  end
end
