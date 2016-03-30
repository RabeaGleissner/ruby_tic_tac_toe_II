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
    until board.game_over? || !players[player_mark(board)].ready?
      ui.draw_board(board)
      board = players[player_mark(board)].make_move(board)
    end
    end_game(board) if board.game_over?
    board
  end

  def player_mark(board)
    x_count = board.count_for(Marks::X)
    o_count = board.count_for(Marks::O)
    if x_count > o_count
      Marks::O
    else
      Marks::X
    end
  end

  private

  def end_game(board)
    ui.draw_board(board)
    ui.announce_winner(board)
  end
end
