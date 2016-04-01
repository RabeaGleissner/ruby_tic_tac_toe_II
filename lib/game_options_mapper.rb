class GameOptionsMapper
  def map(user_choice)
    case user_choice.to_i
    when  1
      :HumanVsHuman
    when 2
      :HumanVsComputer
    when 3
      :ComputerVsHuman
    when 4
      :ComputerVsComputer
    else
      puts "invalid user choice"
    end
  end
end

