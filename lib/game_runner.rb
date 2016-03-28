require 'game'
require 'player_factory'
require 'ui'

class GameRunner
  attr_reader :ui, :game, :player_factory

  GAME_OPTIONS = {1 => "Human vs Human",
                  2 => "Human vs Computer",
                  3 => "Computer vs Human"}

  def initialize(ui, game, player_factory)
    @ui = ui
    @game = game
    @player_factory = player_factory
  end

  def start
    begin
      loop do
        game_option = ui.menu(GAME_OPTIONS)
        players = player_factory.create_players(game_option)
        game.play(players, Board.new)
        break unless ui.replay?
      end
      ui.say_goodbye
    rescue Interrupt => e
      ui.interruption_message
    end
  end
end
