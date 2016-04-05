require 'human_console_player'
require 'computer_player'
require 'human_web_player'
require 'marks'

class PlayerFactory
  include Marks

  def create_console_players(game_mode, ui)
    case game_mode
    when :HumanVsHuman
      {X => HumanConsolePlayer.new(X, ui), O => HumanConsolePlayer.new(O, ui)}
    when :HumanVsComputer
      {X => HumanConsolePlayer.new(X, ui), O => ComputerPlayer.new(O)}
    when :ComputerVsHuman
      {X => ComputerPlayer.new(X), O => HumanConsolePlayer.new(O, ui)}
    end
  end

  def create_web_players(game_mode)
    case game_mode
    when :HumanVsHuman
      {X => HumanWebPlayer.new(X), O => HumanWebPlayer.new(O)}
    when :HumanVsComputer
      {X => HumanWebPlayer.new(X), O => ComputerPlayer.new(O)}
    when :ComputerVsHuman
      {X => ComputerPlayer.new(X), O => HumanWebPlayer.new(O)}
    when :ComputerVsComputer
      {X => ComputerPlayer.new(X), O => ComputerPlayer.new(O)}
    end
  end
end
