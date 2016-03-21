require 'game'
class GameRunner
  attr_reader :ui, :player1, :player2

  GAME_OPTIONS = {1 => "Human vs Human",
                  2 => "Human vs Computer",
                  3 => "Computer vs Human",
                  4 => "Quit program"}

  def initialize(ui, player1, player2)
    @ui = ui
    @player1 =  player1
    @player2 = player2
  end

  def set_up_game
    game_option = ui.menu(GAME_OPTIONS)
    game = Game.new(player1, player2, ui)
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
