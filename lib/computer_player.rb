require 'pry-byebug'
class ComputerPlayer
  attr_reader :computer_mark

  def initialize(computer_mark)
    @computer_mark = computer_mark
  end

  def make_move(board)
    arr = minimax(board, computer_mark)
    board.add_mark(arr[1], computer_mark)
  end

  def minimax(board, current_mark)
    best_score = reset_score(current_mark)
    best_move = -1
    available_moves = board.available_positions

    if board.game_over?
      return [score_for_move(board), -1]
    end

    available_moves.each do |move|
      next_board = board.add_mark(move, current_mark)
      score = minimax(next_board, switch_mark(current_mark))
      if score_favourable_for_computer?(current_mark, score, best_score)
        best_score = score[0]
        best_move = move
      end
    end
    [best_score, best_move]
  end

  def score_for_move(board)
    score = -100
    if board.winner == computer_mark
      score = 10
    elsif board.winner == false
      score = 0
    else
      score = -10
    end
    score
  end

  def switch_mark(mark)
    mark = mark == :X ? :O : :X
  end

  def score_favourable_for_computer?(current_mark, score, best_score)
    current_mark == computer_mark && score[0] >= best_score ||
      current_mark != computer_mark && score[0] <= best_score
  end

  def reset_score(current_mark)
    current_mark == computer_mark ? - 1000 : 1000
  end
end
