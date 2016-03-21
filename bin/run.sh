#!/usr/bin/env ruby
$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require 'game_runner'
require 'human_player'
require 'computer_player'
require 'ui'

ui = Ui.new($stdin, $stdout)
player1 = HumanPlayer.new(:X, ui)
player2 = ComputerPlayer.new(:O)
game_runner = GameRunner.new(ui, player1, player2)
game_runner.set_up_game

