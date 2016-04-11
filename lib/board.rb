require 'marks'

class Board
  attr_reader :grid, :dimension
  include Marks
  def initialize(dimension = 3, marks = empty_board)
    @dimension = dimension
    @grid = marks
  end

  def add_mark(position, mark)
    new_grid = grid.clone
    new_grid[position] = mark
    Board.new(dimension, new_grid)
  end

  def available_positions
    grid.select { |cell| cell != X && cell != O}
  end

  def game_over?
    winner? || full?
  end

  def winner_mark
    winner = nil
    lines.each do |line|
      if all_same_marks?(line)
        winner = line[0]
      end
    end
    winner
  end

  def next_player_mark
    if count_for(Marks::X) >
      count_for(Marks::O)
      Marks::O
    else
      Marks::X
    end
  end

  def winner?
    winner_mark != nil
  end

  def draw?
    full? && !winner?
  end

  def all_same_marks?(line)
    line[0] == line[1] && line[1] == line[2]
  end

  def empty?
    !full?
  end

  def full?
    (grid & empty_board).empty?
  end

  def lines
    lines ||= [rows, columns, diagonals].flatten(1)
  end

  def rows
    grid.each_slice(dimension).to_a
  end

  def columns
    rows.transpose
  end

  def diagonals
    [
      [grid[0], grid[4], grid[8]],
      [grid[2], grid[4], grid[6]]
    ]
  end

  def count_for(mark)
    count = grid.select {|cell| cell == mark}.size
  end

  private

  def empty_board
    (0..8).to_a
  end
end
