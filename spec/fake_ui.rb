class FakeUi

  def initialize
    @announce_winner_called = 0
  end

  def menu(game_options)
    "1"
  end

  def announce_winner(board)
    @announce_winner_called += 1
  end

  def announce_winner_called
    @announce_winner_called
  end

  def request_position(board)
    3
  end

  def menu(options)
  end

  def draw_board(board)
  end

  def say_goodbye
  end

  def replay?
    false 
  end
end
