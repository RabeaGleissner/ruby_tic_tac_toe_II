require 'board'

class BoardFactory
  BOARD_SIZES = { 1 => "3x3",
                  2 => "4x4" }

  def create_board(size)
    Board.new(size)
  end

  def map(user_input)
    case user_input.to_i
    when 1
      3
    when 2
      4
    end
  end
end
