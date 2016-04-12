require 'marks'

class Board
  attr_reader :dimension, :grid
  include Marks

  def initialize(dimension = 3, marks = empty_board(dimension))
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
    all_x?(line) || all_o?(line)
  end

  def all_x?(line)
    all_same = true
    line.each do |cell|
      all_same = all_same && (cell == Marks::X)
    end
    all_same
  end

  def all_o?(line)
    all_same = true
    line.each do |cell|
      all_same = all_same && (cell == Marks::O)
    end
    all_same
  end

  def empty?
    !full?
  end

  def full?
    (grid & empty_board(dimension)).empty?
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
    first, second = [], []
    (0...dimension).each do |i|
      first[i] = grid[(dimension * i) + i]
    end
    offset = dimension - 1
    (0...dimension).each do |i|
      second[i] = grid[offset]
      offset += dimension - 1
    end
    [first, second]
  end

  def count_for(mark)
    count = grid.select {|cell| cell == mark}.size
  end

  private

  def empty_board(dimension)
    size = dimension ** 2
    (0...size).to_a
  end
end
