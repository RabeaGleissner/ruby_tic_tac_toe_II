class GameOptions
  GAME_OPTIONS = {
    1 => "Human vs Human",
    2 => "Human vs Computer",
    3 => "Computer vs Human"
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
    end
  end
end
