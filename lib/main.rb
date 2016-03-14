require_relative 'game'
require_relative 'human_player'
require_relative 'ui'

ui = Ui.new($stdin, $stdout)
player1 = HumanPlayer.new(:X, ui)
player2 = HumanPlayer.new(:O, ui)
game = Game.new(player1, player2, ui)
game.play
