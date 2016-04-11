require 'game'
require 'player_factory'
require 'ui'
require 'game_options'
require 'board_factory'

class GameRunner
  attr_reader :ui, :game, :player_factory

  def initialize(ui, game, player_factory, board_factory)
    @ui = ui
    @game = game
    @player_factory = player_factory
    @board_factory = board_factory
  end

  def start
    begin
      loop do
        game_option = ui.menu(GameOptions::GAME_OPTIONS)
        board_size = ui.board_size_menu(BoardFactory::BOARD_SIZES)
        game.play(player_factory.create_players(game_option), board_factory.create_board(board_size), ui)
        break unless ui.replay?
      end
      ui.say_goodbye
    rescue Interrupt
      ui.interruption_message
    end
  end
end
