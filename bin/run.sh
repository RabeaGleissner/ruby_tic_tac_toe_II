#!/usr/bin/env ruby
$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require 'game_runner'
require 'computer_player'
require 'ui'
require 'board_factory'

ui = Ui.new($stdin, $stdout)
player_factory = PlayerFactory.new(:console)
game = Game.new
game_runner = GameRunner.new(ui, game, player_factory, BoardFactory.new)
game_runner.start
