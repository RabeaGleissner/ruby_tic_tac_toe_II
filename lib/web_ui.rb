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
    @draw = false
    if board.winner_mark.nil?
      @draw = true
    else
      @winner = board.winner_mark
    end
  end

  def winner_to_announce
    @winner
  end

  def announce_draw?
    @draw
  end
end
