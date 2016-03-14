require 'pry-byebug'
class Ui
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

  def draw_board(board)
    puts create_board_image(board)
  end

  def create_board_image(board)
    board_image = "\n"
    counter = 1
    rows = board.rows
    rows.each do |row|
      row.each do |cell|
        board_image += " "
        board_image += draw_one_cell(cell, counter)

        board_image += " |" unless is_last_cell_in_row(cell, row)
        counter +=1
      end
      board_image += "\n-----------\n" unless is_last_row(counter, rows)
    end
    board_image
  end

  private
  def draw_one_cell(cell, counter)
    if is_empty(cell)
      add_empty_cell(counter)
    else
      add_marked(cell)
    end
  end

  def is_empty(cell)
    cell == :E
  end

  def is_last_cell_in_row(cell, row)
    row.index(cell) == row.length - 1
  end

  def add_empty_cell(counter)
    counter.to_s
  end

  def add_marked(cell)
    cell.to_s
  end

  def is_last_row(counter, rows)
    counter == rows.flatten.length + 1
  end
end
