#!/usr/bin/env ruby
$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require 'game_runner'
require 'computer_player'
require 'ui'
require 'game'
require 'board_factory'

game_runner = GameRunner.new(Ui.new($stdin, $stdout), Game.new, PlayerFactory.new(:console), BoardFactory.new)
game_runner.start
