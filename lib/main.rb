require_relative 'game_runner'
require_relative 'human_player'
require_relative 'computer_player'
require_relative 'ui'

ui = Ui.new($stdin, $stdout)
player2 = HumanPlayer.new(:X, ui)
player1 = ComputerPlayer.new(:O)
game_runner = GameRunner.new(ui, player1, player2)
game_runner.set_up_game
