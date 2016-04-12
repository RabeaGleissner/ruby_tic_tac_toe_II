class GameOptions
  GAME_OPTIONS = {
    1 => "Human vs Human",
    2 => "Human vs Computer",
    3 => "Computer vs Human",
    4 => "Computer vs Computer",
    5 => "Human vs Random"
  }

  def map(user_input)
    case user_input.to_i
    when 1
      :HumanVsHuman
    when 2
      :HumanVsComputer
    when 3
      :ComputerVsHuman
    when 4
      :ComputerVsComputer
    when 5
      :HumanVsRandom
    end
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
