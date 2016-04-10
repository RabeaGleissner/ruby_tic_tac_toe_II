require 'board'
require 'marks'

class Game
  include Marks

  def play(players, board, ui)
    ui.draw_board(board)
    current_player = players[Marks::X]
    until board.game_over? || !current_player(players, board).ready?
      board = play_one_round(players, board)
      ui.draw_board(board)
    end
    end_game(board, ui) if board.game_over?
    board
  end

  def play_one_round(players, board)
    current_player(players, board).make_move(board)
  end

  def current_player(players, board)
    players[board.next_player_mark]
  end

  private

  def end_game(board, ui)
    ui.draw_board(board)
    ui.announce_winner(board)
  end
end
