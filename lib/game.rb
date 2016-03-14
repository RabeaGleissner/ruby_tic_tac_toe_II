require_relative 'board'

class Game
  attr_reader :player1, :player2, :ui

  def initialize(player1, player2, ui)
    @player1 = player1
    @player2 = player2
    @ui = ui
  end

  def play
    board = Board.new
    current_player = player1
    while !board.game_over?
      ui.draw_board(board)
      board = current_player.make_move(board)
      current_player = switch_player(current_player)
    end
    ui.announce_winner(board)
  end

  def switch_player(current_player)
    if current_player == player1
      player2
    else
      player1
    end
  end

end
