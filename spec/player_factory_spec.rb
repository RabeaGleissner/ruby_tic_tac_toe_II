require 'spec_helper'
require 'player_factory'
require 'computer_player'
require 'marks'
require 'human_console_player'
require 'ui'

describe PlayerFactory do
  include Marks
  let (:ui) {Ui.new(nil, nil)}

  it "creates a computer player and a human console player" do
    factory = PlayerFactory.new
    expect(factory.create_players(:ComputerVsHuman, :console)[Marks::X]).to be_a ComputerPlayer
    expect(factory.create_players(:ComputerVsHuman, :console)[Marks::O]).to be_a HumanConsolePlayer
  end

  it "creates a human console player and a computer player" do
    factory = PlayerFactory.new
    expect(factory.create_players(:HumanVsComputer, :console)[Marks::X]).to be_a HumanConsolePlayer
    expect(factory.create_players(:HumanVsComputer, :console)[Marks::O]).to be_a ComputerPlayer
  end

  it "creates two human console players" do
    factory = PlayerFactory.new
    expect(factory.create_players(:HumanVsHuman, :console)[Marks::X]).to be_a HumanConsolePlayer
    expect(factory.create_players(:HumanVsHuman, :console)[Marks::O]).to be_a HumanConsolePlayer
   end

  it "creates a human console player and a random player" do
    factory = PlayerFactory.new
    expect(factory.create_players(:HumanVsRandom, :console)[Marks::X]).to be_a HumanConsolePlayer
    expect(factory.create_players(:HumanVsRandom, :console)[Marks::O]).to be_a RandomPlayer
  end

  it "creates two computer players for the console game" do
    factory = PlayerFactory.new
    expect(factory.create_players(:ComputerVsComputer, :console)[Marks::X]).to be_a ComputerPlayer
    expect(factory.create_players(:ComputerVsComputer, :console)[Marks::O]).to be_a ComputerPlayer
  end

  it "creates two human web players" do
    factory = PlayerFactory.new
    expect(factory.create_players(:HumanVsHuman, :web)[Marks::X]).to be_a HumanWebPlayer
    expect(factory.create_players(:HumanVsHuman, :web)[Marks::O]).to be_a HumanWebPlayer
  end

  it "creates a human web player and a computer player" do
    factory = PlayerFactory.new
    expect(factory.create_players(:HumanVsComputer, :web)[Marks::X]).to be_a HumanWebPlayer
    expect(factory.create_players(:HumanVsComputer, :web)[Marks::O]).to be_a ComputerPlayer
  end

  it "creates a computer player and a human web player" do
    factory = PlayerFactory.new
    expect(factory.create_players(:ComputerVsHuman, :web)[Marks::X]).to be_a ComputerPlayer
    expect(factory.create_players(:ComputerVsHuman, :web)[Marks::O]).to be_a HumanWebPlayer
  end

  it "creates two computer players for the web game" do
    factory = PlayerFactory.new
    expect(factory.create_players(:ComputerVsComputer, :web)[Marks::X]).to be_a ComputerPlayer
    expect(factory.create_players(:ComputerVsComputer, :web)[Marks::O]).to be_a ComputerPlayer
  end

  xit "creates a human web player and a random player" do
    factory = PlayerFactory.new
    expect(factory.create_players(:HumanVsRandom, :web)[Marks::X]).to be_a HumanWebPlayer
    expect(factory.create_players(:HumanVsRandom, :web)[Marks::O]).to be_a RandomPlayer
  end
end
