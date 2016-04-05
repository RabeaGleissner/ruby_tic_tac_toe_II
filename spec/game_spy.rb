class GameSpy
  def initialize
    @play_method_calls_count = 0
  end

  def play(players, board, ui)
    @play_method_calls_count += 1
  end

  def play_method_calls_count
    @play_method_calls_count
  end
end
