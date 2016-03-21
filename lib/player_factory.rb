class PlayerFactory
  attr_reader :ui

  def initialize(ui)
    @ui = ui
  end

  def create_player1(game_mode)
    if game_mode == "1" || game_mode == "2"
      HumanPlayer.new(:X, ui)
    elsif game_mode == "3"
      ComputerPlayer.new(:X)
    end
  end

  def create_player2(game_mode)
    if game_mode == "1" || game_mode == "3"
      HumanPlayer.new(:O, ui)
    elsif game_mode == "2"
      ComputerPlayer.new(:O)
    end
  end
end
