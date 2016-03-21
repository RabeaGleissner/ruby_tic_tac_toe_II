require 'game'
require 'player_factory'

class GameRunner
  attr_reader :ui, :player_factory

  GAME_OPTIONS = {1 => "Human vs Human",
                  2 => "Human vs Computer",
                  3 => "Computer vs Human",
                  4 => "Quit program"}

  def initialize(ui, player_factory)
    @ui = ui
    @player_factory = player_factory
  end

  def set_up_game
    game_option = ui.menu(GAME_OPTIONS)
    game = Game.new(player_factory.create_player1(game_option), player_factory.create_player2(game_option), ui)
    game.play
    replay
  end

  def replay
    if player1.play_again? == true
      set_up_game
    else
      ui.say_goodbye
    end
  end
end
