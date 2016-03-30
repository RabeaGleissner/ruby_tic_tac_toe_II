require 'board'
class Game
  attr_reader :ui

  def initialize(ui)
    @ui = ui
  end

  def play(players, board)
    current_player = players.first
    until board.game_over? || !current_player.ready?
      ui.draw_board(board)
      board = current_player.make_move(board)
      current_player = switch(players).first
    end
    end_game(board) if board.game_over?
    board.rows
  end

  private

  def switch(players)
    players.reverse!
  end

  def end_game(board)
    ui.draw_board(board)
    ui.announce_winner(board)
  end
end
