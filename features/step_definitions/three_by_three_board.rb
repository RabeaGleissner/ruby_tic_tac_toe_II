require 'board'
require 'game'
require 'marks'
require_relative '../../spec/player_with_preset_data'
require_relative '../../spec/fake_ui'

Given(/^an empty three by three board$/) do
  @board = Board.new
end

When(/^the first player chooses the top left position$/) do
  @player1 = PlayerWithPresetData.new(Marks::X)
  @player1.add_move(0)
end

When(/^the second player chooses the bottom left position$/) do
  @player2 = PlayerWithPresetData.new(Marks::O)
  @player2.add_move(6)
end

When(/^the first player chooses the top middle position$/) do
  @player1.add_move(1)
end

When(/^the second player chooses the bottom middle position$/) do
  @player2.add_move(7)
end

When(/^the first player chooses the top right position$/) do
  @player1.add_move(2)
end

Then(/^the first player wins\.$/) do
  replay_option = false
  new_board = Game.new.play({Marks::X => @player1, Marks::O => @player2}, @board, FakeUi.new(replay_option))
  expect(new_board.winner_mark).to eq Marks::X
end
