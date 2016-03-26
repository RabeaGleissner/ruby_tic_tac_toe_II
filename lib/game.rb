require 'board'
class Game
  attr_reader :ui

  def initialize(ui)
    @ui = ui
  end

  def play(player1, player2, board)
    current_player = player1
    until board.game_over? || !current_player.ready?
      ui.draw_board(board)
      board = current_player.make_move(board)
      current_player = switch(current_player, player1, player2)
    end
    if board.game_over?
      end_game(board)
    end
    board
  end


  private

  def switch(current_player, player1, player2)
    current_player == player1 ? player2 : player1
  end

  def end_game(board)
    ui.draw_board(board)
    ui.announce_winner(board)
  end
end
