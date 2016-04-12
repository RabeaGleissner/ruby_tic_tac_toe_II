require 'board'
require 'game'
require 'marks'
require_relative '../../spec/player_with_preset_data'
require_relative '../../spec/fake_ui'

Given(/^an empty four by four board$/) do
  @board = Board.new(4)
  @player1 = PlayerWithPresetData.new(Marks::X)
  @player2 = PlayerWithPresetData.new(Marks::O)
end

When(/^the first player chooses the first position in the first row$/) do
  @player1.add_move(0)
end

When(/^the first player chooses the third position in the first row$/) do
  @player1.add_move(2)
end

When(/^the first player chooses the first position in the second row$/) do
  @player1.add_move(4)
end

When(/^the first player chooses the third position in the second row$/) do
  @player1.add_move(6)
end

When(/^the first player chooses the first position in the third row$/) do
  @player1.add_move(8)
end

When(/^the first player chooses the third position in the third row$/) do
  @player1.add_move(10)
end

When(/^the first player chooses the first position in the last row$/) do
  @player1.add_move(12)
end

When(/^the first player chooses the second position in the last row$/) do
  @player1.add_move(13)
end

When(/^the first player chooses the last position in the last row$/) do
  @player1.add_move(15)
end

When(/^the second player chooses the second position in the first row$/) do
  @player2.add_move(1)
end

When(/^the second player chooses the last position in the first row$/) do
  @player2.add_move(3)
end

When(/^the second player chooses the second position in the second row$/) do
  @player2.add_move(5)
end

When(/^the second player chooses the last position in the second row$/) do
  @player2.add_move(7)
end

When(/^the second player chooses the second position in the third row$/) do
  @player2.add_move(9)
end

When(/^the second player chooses the last position in the third row$/) do
  @player2.add_move(11)
end

When(/^the second player chooses the first position in the last row$/) do
  @player2.add_move(12)
end

When(/^the second player chooses the third position in the last row$/) do
  @player2.add_move(14)
end

When(/^the second player chooses the last position in the last row$/) do
  @player2.add_move(15)
end

Then(/^the game is a draw\.$/) do
  replay_option = false
  new_board = Game.new.play({Marks::X => @player1, Marks::O => @player2}, @board, FakeUi.new(replay_option))
  expect(new_board.draw?).to be true
end

Then(/^the second player wins\.$/) do
  replay_option = false
  new_board = Game.new.play({Marks::X => @player1, Marks::O => @player2}, @board, FakeUi.new(replay_option))
  expect(new_board.winner_mark).to eq Marks::O
end
