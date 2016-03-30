require 'board'

class WebUi

  def draw_board(board)
    @grid = board.rows
  end

  def game_state_rows
    if @grid
      @grid
    else
      Board.new.rows
    end
  end

  def announce_winner(board)
    @winner = board.winner_mark
  end

  def winner_to_display
    @winner
  end
end
