require 'marks'
require 'game_options_mapper'

class Ui
  include Marks
  attr_reader :input, :output

  CLEAR_SCREEN = "\e[H\e[2J"

  def initialize(input, output)
    @input = input
    @output = output
  end

  def menu(game_options)
    output.puts "#{CLEAR_SCREEN}::: WELCOME TO TIC TAC TOE :::\n\n"
    output.puts "Please indicate your desired game mode:\n\n"
    game_options.each do |number, option|
      output.puts "#{number} - #{option}"
    end
    output.puts "--> "
    get_game_mode(game_options)
  end

  def get_game_mode(game_options)
    mode = input.gets.chomp
    if (1..game_options.length).include? mode.to_i || mode == "q"
      GameOptionsMapper.new.map(mode)
    else
      game_mode_selection_error
      menu(game_options)
    end
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
      draw_board(board)
      invalid_position_error
      request_position(board)
    end
  end

  def announce_winner(board)
    if board.winner?
      output.puts "\nGame over! Winner is #{board.winner_mark}."
    else
      output.puts "\nGame over! It's a draw."
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

  def interruption_message
    output.puts CLEAR_SCREEN + "You interrupted the application. Bye!\n\n"
  end

  def draw_board(board)
    output.puts CLEAR_SCREEN + create_board_image(board)
  end

  private

  def invalid_position_error
    output.puts "Unfortunately the position you entered is not valid."
  end

  def game_mode_selection_error
    output.puts "Please select a valid game mode!"
  end

  def create_board_image(board)
    line = "\n-----------\n"
    pipe = " |"
    board_image = line
    rows = board.rows.flatten
    index = 0
    rows.each do |cell|
      board_image += draw_one_cell(cell)
      board_image += pipe unless last_cell_in_row?(index, board)
      board_image += line if last_cell_in_row?(index, board)
      index += 1
    end
    board_image
  end

  def draw_one_cell(cell)
    cell += 1 unless cell == X || cell == O
    " " + (cell).to_s
  end

  def last_cell_in_row?(index, board)
    board_size = board.rows.first.length
    index == board_size - 1 || index == (board_size * 2) - 1 || index == (board_size * 3) - 1
  end
end
