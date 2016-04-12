require 'spec_helper'
require 'players/player_factory'
require 'players/computer_player'
require 'marks'
require 'players/human_console_player'
require 'ui'

describe PlayerFactory do
  include Marks
  let (:ui) {Ui.new(nil, nil)}

  it "creates a computer player and a human console player" do
    factory = PlayerFactory.new(:console)
    expect(factory.create_players(:ComputerVsHuman)[Marks::X]).to be_a ComputerPlayer
    expect(factory.create_players(:ComputerVsHuman)[Marks::O]).to be_a HumanConsolePlayer
  end

  it "creates a human console player and a computer player" do
    factory = PlayerFactory.new(:console)
    expect(factory.create_players(:HumanVsComputer)[Marks::X]).to be_a HumanConsolePlayer
    expect(factory.create_players(:HumanVsComputer)[Marks::O]).to be_a ComputerPlayer
  end

  it "creates two human console players" do
    factory = PlayerFactory.new(:console)
    expect(factory.create_players(:HumanVsHuman)[Marks::X]).to be_a HumanConsolePlayer
    expect(factory.create_players(:HumanVsHuman)[Marks::O]).to be_a HumanConsolePlayer
   end

  it "creates a human console player and a random player" do
    factory = PlayerFactory.new(:console)
    expect(factory.create_players(:HumanVsRandom)[Marks::X]).to be_a HumanConsolePlayer
    expect(factory.create_players(:HumanVsRandom)[Marks::O]).to be_a RandomPlayer
  end

  it "creates two computer players for the console game" do
    factory = PlayerFactory.new(:console)
    expect(factory.create_players(:ComputerVsComputer)[Marks::X]).to be_a ComputerPlayer
    expect(factory.create_players(:ComputerVsComputer)[Marks::O]).to be_a ComputerPlayer
  end

  it "creates two human web players" do
    factory = PlayerFactory.new(:web)
    expect(factory.create_players(:HumanVsHuman)[Marks::X]).to be_a HumanWebPlayer
    expect(factory.create_players(:HumanVsHuman)[Marks::O]).to be_a HumanWebPlayer
  end

  it "creates a human web player and a computer player" do
    factory = PlayerFactory.new(:web)
    expect(factory.create_players(:HumanVsComputer)[Marks::X]).to be_a HumanWebPlayer
    expect(factory.create_players(:HumanVsComputer)[Marks::O]).to be_a ComputerPlayer
  end

  it "creates a computer player and a human web player" do
    factory = PlayerFactory.new(:web)
    expect(factory.create_players(:ComputerVsHuman)[Marks::X]).to be_a ComputerPlayer
    expect(factory.create_players(:ComputerVsHuman)[Marks::O]).to be_a HumanWebPlayer
  end

  it "creates two computer players for the web game" do
    factory = PlayerFactory.new(:web)
    expect(factory.create_players(:ComputerVsComputer)[Marks::X]).to be_a ComputerPlayer
    expect(factory.create_players(:ComputerVsComputer)[Marks::O]).to be_a ComputerPlayer
  end

  it "creates a human web player and a random player" do
    factory = PlayerFactory.new(:web)
    expect(factory.create_players(:HumanVsRandom)[Marks::X]).to be_a HumanWebPlayer
    expect(factory.create_players(:HumanVsRandom)[Marks::O]).to be_a RandomPlayer
  end
end
