class HumanWebPlayer
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def add_move(position)
    @move = position
  end

  def make_move(board)
    move_to_return = @move
    @move = nil
    move_to_return
  end

  def ready?
    @move != nil
  end
end
