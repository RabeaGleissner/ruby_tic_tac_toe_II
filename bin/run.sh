#!/usr/bin/env ruby
$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require 'game_runner'
require 'ui'
require 'game'
require 'board_factory'
require 'players/player_factory'

game_runner = GameRunner.new(Ui.new($stdin, $stdout), Game.new, PlayerFactory.new(:console), BoardFactory.new)
game_runner.start
