class GameSpy

  def initialize
    @play_method_was_called = false
  end

  def play(player1, player2)
    @play_method_was_called = true
  end

  def called_play_method?
    @play_method_was_called
  end
end
