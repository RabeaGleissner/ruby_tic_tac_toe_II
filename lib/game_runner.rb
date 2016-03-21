require 'game'
class GameRunner
  attr_reader :ui, :player1, :player2

  def initialize(ui, player1, player2)
    @ui = ui
    @player1 =  player1
    @player2 = player2
  end

  def set_up_game
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
