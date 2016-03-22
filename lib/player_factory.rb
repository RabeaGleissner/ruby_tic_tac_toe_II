class PlayerFactory
  attr_reader :ui

  def initialize(ui)
    @ui = ui
  end

  def create_players(game_mode)
    if game_mode == "1"
      [HumanPlayer.new(:X, ui), HumanPlayer.new(:O, ui)]
    elsif game_mode == "2"
      [HumanPlayer.new(:X, ui), ComputerPlayer.new(:O)]
    elsif game_mode == "3"
      [ComputerPlayer.new(:X), HumanPlayer.new(:O, ui)]
    end
  end
end
