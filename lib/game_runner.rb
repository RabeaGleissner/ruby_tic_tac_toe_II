require 'game'
require 'player_factory'

class GameRunner
  attr_reader :ui, :game, :player_factory

  GAME_OPTIONS = {1 => "Human vs Human",
                  2 => "Human vs Computer",
                  3 => "Computer vs Human",
                  4 => "Quit program"}

  def initialize(ui, game, player_factory)
    @ui = ui
    @game = game
    @player_factory = player_factory
  end

  def start
    game_option = ui.menu(GAME_OPTIONS)
    game.play(player_factory.create_player1(game_option),
              player_factory.create_player2(game_option))
    replay
  end

  def replay
    if ui.replay? == true
      start
    else
      ui.say_goodbye
    end
  end
end
