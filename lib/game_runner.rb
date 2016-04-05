require 'game'
require 'player_factory'
require 'ui'
require 'game_options_mapper'

class GameRunner
  attr_reader :ui, :game, :player_factory

  def initialize(ui, game, player_factory)
    @ui = ui
    @game = game
    @player_factory = player_factory
  end

  def start
    begin
      loop do
        game_option = ui.menu(GameOptionsMapper.new.game_options)
        game.play(player_factory.create_console_players(game_option, ui), Board.new, ui)
        break unless ui.replay?
      end
      ui.say_goodbye
    rescue Interrupt
      ui.interruption_message
    end
  end
end
