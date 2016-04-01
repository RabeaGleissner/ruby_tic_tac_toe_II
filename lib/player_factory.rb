require 'human_console_player'
require 'computer_player'
require 'human_web_player'
require 'marks'

class PlayerFactory
  include Marks
  attr_reader :ui

  def initialize(ui)
    @ui = ui
  end

  def create_console_players(game_mode)
    if game_mode == "1"
      {X => HumanConsolePlayer.new(X, ui), O => HumanConsolePlayer.new(O, ui)}
    elsif game_mode == "2"
      {X => HumanConsolePlayer.new(X, ui), O => ComputerPlayer.new(O)}
    elsif game_mode == "3"
      {X => ComputerPlayer.new(X), O => HumanConsolePlayer.new(O, ui)}
    end
  end

  def create_web_players(game_mode)
    if game_mode == :HumanVsHuman
      {X => HumanWebPlayer.new(X), O => HumanWebPlayer.new(O)}
    elsif game_mode == :HumanVsComputer
      {X => HumanWebPlayer.new(X), O => ComputerPlayer.new(O)}
    elsif game_mode == :ComputerVsHuman
      {X => ComputerPlayer.new(X), O => HumanWebPlayer.new(O)}
    elsif game_mode == :ComputerVsComputer
      {X => ComputerPlayer.new(X), O => ComputerPlayer.new(O)}
    end
  end
end
