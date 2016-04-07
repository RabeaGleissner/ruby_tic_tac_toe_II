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
    expect(factory.create_console_players(:ComputerVsHuman, ui)[Marks::X]).to be_a ComputerPlayer
    expect(factory.create_console_players(:ComputerVsHuman, ui)[Marks::O]).to be_a HumanConsolePlayer
  end

  it "creates a human console player and a computer player" do
    factory = PlayerFactory.new
    expect(factory.create_console_players(:HumanVsComputer, ui)[Marks::X]).to be_a HumanConsolePlayer
    expect(factory.create_console_players(:HumanVsComputer, ui)[Marks::O]).to be_a ComputerPlayer
  end

  it "creates two human console players" do
    factory = PlayerFactory.new
    expect(factory.create_console_players(:HumanVsHuman, ui)[Marks::X]).to be_a HumanConsolePlayer
    expect(factory.create_console_players(:HumanVsHuman, ui)[Marks::O]).to be_a HumanConsolePlayer
   end

  it "creates a human console player and a random player" do
    factory = PlayerFactory.new
    expect(factory.create_console_players(:HumanVsRandom, ui)[Marks::X]).to be_a HumanConsolePlayer
    expect(factory.create_console_players(:HumanVsRandom, ui)[Marks::O]).to be_a RandomPlayer
  end

  it "creates two computer players for the web game" do
    factory = PlayerFactory.new
    expect(factory.create_console_players(:ComputerVsComputer, ui)[Marks::X]).to be_a ComputerPlayer
    expect(factory.create_console_players(:ComputerVsComputer, ui)[Marks::O]).to be_a ComputerPlayer
  end

  it "creates two human web players" do
    factory = PlayerFactory.new
    expect(factory.create_web_players(:HumanVsHuman)[Marks::X]).to be_a HumanWebPlayer
    expect(factory.create_web_players(:HumanVsHuman)[Marks::O]).to be_a HumanWebPlayer
  end

  it "creates a human web player and a computer player" do
    factory = PlayerFactory.new
    expect(factory.create_web_players(:HumanVsComputer)[Marks::X]).to be_a HumanWebPlayer
    expect(factory.create_web_players(:HumanVsComputer)[Marks::O]).to be_a ComputerPlayer
  end

  it "creates a computer player and a human web player" do
    factory = PlayerFactory.new
    expect(factory.create_web_players(:ComputerVsHuman)[Marks::X]).to be_a ComputerPlayer
    expect(factory.create_web_players(:ComputerVsHuman)[Marks::O]).to be_a HumanWebPlayer
  end

  it "creates two computer players for the web game" do
    factory = PlayerFactory.new
    expect(factory.create_web_players(:ComputerVsComputer)[Marks::X]).to be_a ComputerPlayer
    expect(factory.create_web_players(:ComputerVsComputer)[Marks::O]).to be_a ComputerPlayer
  end

  xit "creates a human web player and a random player" do
    factory = PlayerFactory.new
    expect(factory.create_web_players(:HumanVsRandom)[Marks::X]).to be_a HumanWebPlayer
    expect(factory.create_web_players(:HumanVsRandom)[Marks::O]).to be_a RandomPlayer
  end
end
