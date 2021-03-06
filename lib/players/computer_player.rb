require 'marks'

class ComputerPlayer
  include Marks
  attr_reader :computer_mark
  BEST_MOVE_PLACEHOLDER = -1
  INITIAL_ALPHA_VALUE = -10000
  INITIAL_BETA_VALUE = 10000
  RESET_SCORE = -100

  def initialize(computer_mark)
    @computer_mark = computer_mark
  end

  def make_move(board)
    scored_move = minimax(9, board,
                          computer_mark, INITIAL_ALPHA_VALUE, INITIAL_BETA_VALUE)
    board.add_mark(scored_move[1], computer_mark)
  end

  def minimax(depth, board, current_mark, alpha, beta)
    best_score = initialize_best_score(current_mark)
    best_move = BEST_MOVE_PLACEHOLDER

    if board.game_over? || depth == 0
      return [score_for_move(board, depth), best_move]
    end

    board.available_positions.each do |move|
      next_board = board.add_mark(move, current_mark)
      move_with_score = minimax(depth - 1, next_board, switch_mark(current_mark), alpha, beta)

      if score_favourable_for_computer?(current_mark, move_with_score, best_score)
        best_score = move_with_score[0]
        best_move = move
      end

      if current_mark == computer_mark
        alpha = [alpha, best_score].max
      else
        beta = [beta, best_score].min
      end

      break if alpha >= beta
    end
    [best_score, best_move]
  end

  def score_for_move(board, depth)
    if !board.winner?
      0
    elsif board.winner_mark == computer_mark
      depth
    else
      -depth
    end
  end

  def ready?
    true
  end

  private

  def score_favourable_for_computer?(current_mark, score, best_score)
    if (computer?(current_mark))
      score[0] > best_score
    else
      score[0] < best_score
    end
  end

  def computer?(current_mark)
    current_mark == computer_mark
  end

  def initialize_best_score(current_mark)
    current_mark == computer_mark ? -1000 : 1000
  end
end
