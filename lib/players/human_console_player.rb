require 'ui'

class HumanConsolePlayer
  attr_reader :mark, :ui

  def initialize(mark, ui = Ui.new($stdin, $stdout))
    @mark = mark
    @ui = ui
  end

  def make_move(board)
    board.add_mark(ui.request_position(board), mark)
  end

  def ready?
    true
  end
end
