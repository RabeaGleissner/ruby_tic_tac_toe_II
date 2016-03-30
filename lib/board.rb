class Board
  attr_reader :grid, :dimension

  def initialize(marks = (0..8).to_a)
    @grid = marks
    @dimension = Math.sqrt(@grid.size).to_i
  end

  def add_mark(position, mark)
    new_grid = grid.clone
    new_grid[position] = mark
    Board.new(new_grid)
  end

  def available_positions
    grid.select { |cell| cell != :X && cell != :O}
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

  def winner?
    winner_mark != nil
  end

  def all_same_marks?(line)
    line[0] == line[1] && line[1] == line[2]
  end

  def empty?
    !full?
  end

  def full?
    (grid & (0..8).to_a).empty?
  end

  def lines
    @lines ||= [rows, columns, diagonals].flatten(1)
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
end
