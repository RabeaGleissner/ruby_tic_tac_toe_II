require 'human_console_player'
require 'marks'

class PlayerFactory
  include Marks
  attr_reader :ui

  def initialize(ui)
    @ui = ui
  end

  def create_players(game_mode)
    if game_mode == "1"
      [HumanConsolePlayer.new(X, ui), HumanConsolePlayer.new(O, ui)]
    elsif game_mode == "2"
      [HumanConsolePlayer.new(X, ui), ComputerPlayer.new(O)]
    elsif game_mode == "3"
      [ComputerPlayer.new(X), HumanConsolePlayer.new(O, ui)]
    end
  end
end
