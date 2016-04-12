class GameOptions
  GAME_OPTIONS = {
    1 => :HumanVsHuman,
    2 => :HumanVsComputer,
    3 => :ComputerVsHuman,
    4 => :ComputerVsComputer,
    5 => :HumanVsRandom
  }

  def map(user_input)
    GAME_OPTIONS[user_input.to_i]
  end

  def format_for_display(game_options_symbol)
    word_array = split_into_array(game_options_symbol)
    lower_case(word_array[1])
    turn_into_string(word_array)
  end

  def turn_into_string(array)
    array.join(" ")
  end

  def split_into_array(game_options_symbol)
    game_options_symbol.to_s.split /(?=[A-Z])/
  end

  def lower_case(word)
    word.downcase!
  end
end
