require 'spec_helper'
require 'player_with_preset_data'
require 'human_web_player'
require 'ui'
require 'fake_ui'
require 'game.rb'
require 'marks'

describe Game do

  it "plays game once" do
    player1 = PlayerWithPresetData.new(Marks::X, [0,1,2])
    player2 = PlayerWithPresetData.new(Marks::O, [3,4])
    replay = [false]
    fake_ui = FakeUi.new(replay)
    game = Game.new(fake_ui)
    game.play({Marks::X => player1, Marks::O => player2}, Board.new)
    expect(fake_ui.announce_winner_called).to eq 1
  end

  it "knows that it's player O's turn" do
    board = Board.new([Marks::X, Marks::O, Marks::X, 3, 4, 5, 6, 7, 8])
    ui = Ui.new(nil, nil)
    game = Game.new(ui)
    players = {Marks::X => HumanWebPlayer.new(Marks::X), Marks::O => HumanWebPlayer.new(Marks::O)}
    current_player = game.current_player(players, board)
    expect(current_player.mark).to eq Marks::O
  end

  it "knows that it's player X's turn" do
    board = Board.new([Marks::X, Marks::O, Marks::X, Marks::O, 4, 5, 6, 7, 8])
    ui = Ui.new(nil, nil)
    game = Game.new(ui)
    players = {Marks::X => HumanWebPlayer.new(Marks::X), Marks::O => HumanWebPlayer.new(Marks::O)}
    current_player = game.current_player(players, board)
    expect(current_player.mark).to eq Marks::X
  end
end
