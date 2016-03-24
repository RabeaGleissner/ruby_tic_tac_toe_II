require 'board'

class WebUi

  def draw_board(board)
    @grid = board.rows
  end

  def game_state_rows
    if @grid != nil
      @grid
    else
      Board.new.rows
    end
  end
end
