class BoardSize
  SIZES = { 1 => 3,
            2 => 4 }

  def map(user_input)
    SIZES[user_input.to_i]
  end

  def display(size)
    "#{size}x#{size} board"
  end
end
