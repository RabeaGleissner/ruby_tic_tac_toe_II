#!/usr/bin/env ruby
$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require 'game_runner'
require 'computer_player'
require 'ui'

ui = Ui.new($stdin, $stdout)
player_factory = PlayerFactory.new
game = Game.new
game_runner = GameRunner.new(ui, game, player_factory)
game_runner.start
