require 'human_console_player'
require 'computer_player'
require 'human_web_player'
require 'random_player'
require 'marks'

class PlayerFactory
  include Marks

  def create_players(game_mode, app_version)
    if game_mode == :HumanVsHuman
      if app_version == :console
        {X => HumanConsolePlayer.new(X), O => HumanConsolePlayer.new(O)}
      else
        {X => HumanWebPlayer.new(X), O => HumanWebPlayer.new(O)}
      end
    elsif game_mode == :HumanVsComputer
      if app_version == :console
        {X => HumanConsolePlayer.new(X), O => ComputerPlayer.new(O)}
      else
        {X => HumanWebPlayer.new(X), O => ComputerPlayer.new(O)}
      end
    elsif game_mode == :ComputerVsHuman
      if app_version == :console
        {X => ComputerPlayer.new(X), O => HumanConsolePlayer.new(O)}
      else
        {X => ComputerPlayer.new(X), O => HumanWebPlayer.new(O)}
      end
    elsif game_mode == :ComputerVsComputer
      {X => ComputerPlayer.new(X), O => ComputerPlayer.new(O)}
    elsif game_mode == :HumanVsRandom
      if app_version == :console
        {X => HumanConsolePlayer.new(X), O => RandomPlayer.new(O)}
      else
        {X => ComputerPlayer.new(X), O => ComputerPlayer.new(O)}
      end
    end
  end
end
