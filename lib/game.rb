require 'board'
require 'marks'

class Game
  include Marks
  attr_reader :ui

  def initialize(ui)
    @ui = ui
  end

  def play(players, board)
    current_player = players[Marks::X]
    until board.game_over? || !current_player(players, board).ready?
      ui.draw_board(board)
      board = current_player(players, board).make_move(board)
    end
    end_game(board) if board.game_over?
    board
  end

  def current_player(players, board)
    players[current_player_mark(board)]
  end

  private

  def current_player_mark(board)
    if board.count_for(Marks::X) >
      board.count_for(Marks::O)
      Marks::O
    else
      Marks::X
    end
  end

  def end_game(board)
    ui.draw_board(board)
    ui.announce_winner(board)
  end
end
