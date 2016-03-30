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
      {X => HumanConsolePlayer.new(X, ui), O => HumanConsolePlayer.new(O, ui)}
    elsif game_mode == "2"
      {X => HumanConsolePlayer.new(X, ui), O => ComputerPlayer.new(O)}
    elsif game_mode == "3"
      {X => ComputerPlayer.new(X), O => HumanConsolePlayer.new(O, ui)}
    end
  end
end
