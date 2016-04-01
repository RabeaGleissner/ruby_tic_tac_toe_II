require 'spec_helper'
require 'player_factory'
require 'computer_player'
require 'marks'
require 'human_console_player'
require 'ui'

describe PlayerFactory do
  include Marks
  let (:ui) {Ui.new(nil, nil)}

  HUMAN_VS_HUMAN = "1"
  HUMAN_VS_COMPUTER = "2"
  COMPUTER_VS_HUMAN = "3"
  COMPUTER_VS_COMPUTER = "4"

  it "creates a computer player and a human console player" do
    factory = PlayerFactory.new(ui)
    expect(factory.create_console_players(COMPUTER_VS_HUMAN)[Marks::X]).to be_a ComputerPlayer
    expect(factory.create_console_players(COMPUTER_VS_HUMAN)[Marks::O]).to be_a HumanConsolePlayer
  end

  it "creates a human console player and a computer player" do
    factory = PlayerFactory.new(ui)
    expect(factory.create_console_players(HUMAN_VS_COMPUTER)[Marks::X]).to be_a HumanConsolePlayer
    expect(factory.create_console_players(HUMAN_VS_COMPUTER)[Marks::O]).to be_a ComputerPlayer
  end

  it "creates two human console players" do
    factory = PlayerFactory.new(ui)
    expect(factory.create_console_players(HUMAN_VS_HUMAN)[Marks::X]).to be_a HumanConsolePlayer
    expect(factory.create_console_players(HUMAN_VS_HUMAN)[Marks::O]).to be_a HumanConsolePlayer
   end

  it "creates two human web players" do
    factory = PlayerFactory.new(ui)
    expect(factory.create_web_players(:HumanVsHuman)[Marks::X]).to be_a HumanWebPlayer
    expect(factory.create_web_players(:HumanVsHuman)[Marks::O]).to be_a HumanWebPlayer
  end

  it "creates a human web player and a computer player" do
    factory = PlayerFactory.new(ui)
    expect(factory.create_web_players(:HumanVsComputer)[Marks::X]).to be_a HumanWebPlayer
    expect(factory.create_web_players(:HumanVsComputer)[Marks::O]).to be_a ComputerPlayer
  end

  it "creates a human web player and a computer player" do
    factory = PlayerFactory.new(ui)
    expect(factory.create_web_players(:ComputerVsHuman)[Marks::X]).to be_a ComputerPlayer
    expect(factory.create_web_players(:ComputerVsHuman)[Marks::O]).to be_a HumanWebPlayer
  end

  it "creates two computer players for the web game" do
    factory = PlayerFactory.new(ui)
    expect(factory.create_web_players(:ComputerVsComputer)[Marks::X]).to be_a ComputerPlayer
    expect(factory.create_web_players(:ComputerVsComputer)[Marks::O]).to be_a ComputerPlayer
  end
end
