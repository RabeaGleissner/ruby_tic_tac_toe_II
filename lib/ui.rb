class Ui
  CLEAR_SCREEN = "\e[H\e[2J"
  attr_reader :input, :output

  def initialize(input, output)
    @input = input
    @output = output
  end

  def request_position(board)
    output.puts "\nPlease enter a position:"
    get_position(board)
  end

  def get_position(board)
    position = input.gets.chomp.to_i - 1
    if board.available_positions.include? position
      position
    else
      request_position(board)
    end
  end

  def announce_winner(board)
    if board.winner == false
      output.puts "\nGame over! It's a draw."
    else
      output.puts "\nGame over! Winner is #{board.winner}."
    end
  end

  def replay?
    output.puts "\nDo you want to play again?\n\n- Enter y for yes\n- Enter n for no"
    user_wants_to_play_again?
  end

  def user_wants_to_play_again?
    user_choice = input.gets.chomp.downcase
    if user_choice == "y"
      true
    elsif user_choice == "n"
      false
    else
      replay?
    end
  end

  def say_goodbye
    output.puts CLEAR_SCREEN + "Byyyee!\n\n"
  end

  def draw_board(board)
    output.puts CLEAR_SCREEN + create_board_image(board)
  end

  def create_board_image(board)
    line = "\n-----------\n"
    pipe = " |"
    board_image = line
    rows = board.rows.flatten
    rows.each do |cell|
      board_image += draw_one_cell(cell)
      board_image += pipe unless last_cell_in_row?(rows.index(cell), board)
      board_image += line if last_cell_in_row?(rows.index(cell), board)
    end
    board_image
  end

  private
  def draw_one_cell(cell)
    cell += 1 unless cell == :X || cell == :O
    " " + (cell).to_s
  end

  def empty?(cell)
    (0..8).to_a.include? cell
  end

  def last_cell_in_row?(index, board)
    board_size = board.rows.first.length
    index == board_size - 1 || index == (board_size * 2) - 1 || index == (board_size * 3) - 1
  end
end
