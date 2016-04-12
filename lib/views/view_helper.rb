require 'game_options'
require 'board_size'

module ViewHelper
  def format_board_size(size)
    BoardSize.new.display(size)
  end

  def format_game_options(symbol)
    GameOptions.new.format_for_display(symbol)
  end

  def convert_to_kebab_case(words)
    words.split( ).each {|word| word.downcase!}.join("-")
  end
end
