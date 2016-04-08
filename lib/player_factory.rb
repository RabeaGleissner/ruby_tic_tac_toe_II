require 'human_console_player'
require 'computer_player'
require 'human_web_player'
require 'random_player'
require 'marks'

class PlayerFactory
  include Marks
  attr_reader :app_type

  def initialize(app_type)
    @app_type = app_type
  end

  def create_players(game_mode)
    if game_mode == :HumanVsHuman
      create_human_vs_human_players
    elsif game_mode == :HumanVsComputer
      create_human_vs_computer_players
    elsif game_mode == :ComputerVsHuman
      create_computer_vs_human_players
    elsif game_mode == :ComputerVsComputer
      create_computer_vs_computer_players
    elsif game_mode == :HumanVsRandom
      create_human_vs_random_players
    end
  end

  def create_human_vs_human_players
    if app_type == :console
      {Marks::X => HumanConsolePlayer.new(Marks::X), Marks::O => HumanConsolePlayer.new(Marks::O)}
    elsif app_type == :web
      {Marks::X => HumanWebPlayer.new(Marks::X), Marks::O => HumanWebPlayer.new(Marks::O)}
    end
  end

  def create_human_vs_computer_players
    if app_type == :console
      {Marks::X => HumanConsolePlayer.new(Marks::X), Marks::O => ComputerPlayer.new(Marks::O)}
    elsif app_type == :web
      {Marks::X => HumanWebPlayer.new(Marks::X), Marks::O => ComputerPlayer.new(Marks::O)}
    end
  end

  def create_computer_vs_human_players
    if app_type == :console
      {Marks::X => ComputerPlayer.new(Marks::X), Marks::O => HumanConsolePlayer.new(Marks::O)}
    elsif app_type == :web
      {Marks::X => ComputerPlayer.new(Marks::X), Marks::O => HumanWebPlayer.new(Marks::O)}
    end
  end

  def create_computer_vs_computer_players
    {Marks::X => ComputerPlayer.new(Marks::X), Marks::O => ComputerPlayer.new(Marks::O)}
  end

  def create_human_vs_random_players
    if app_type == :console
      {Marks::X => HumanConsolePlayer.new(Marks::X), Marks::O => RandomPlayer.new(Marks::O)}
    elsif app_type == :web
      {Marks::X => HumanWebPlayer.new(Marks::X), Marks::O => RandomPlayer.new(Marks::O)}
    end
  end
end
