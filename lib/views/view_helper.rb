require 'game_options'

module ViewHelper
  def format(symbol)
    GameOptions.new.format_for_display(symbol)
  end

  def convert_to_kebab_case(words)
    words.split( ).each {|word| word.downcase!}.join("-")
  end
end
