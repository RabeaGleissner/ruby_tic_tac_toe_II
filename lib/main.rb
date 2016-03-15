require_relative 'game_runner'
require_relative 'human_player'
require_relative 'ui'

ui = Ui.new($stdin, $stdout)
player1 = HumanPlayer.new(:X, ui)
player2 = HumanPlayer.new(:O, ui)
game_runner = GameRunner.new(ui, player1, player2)
game_runner.set_up_game
