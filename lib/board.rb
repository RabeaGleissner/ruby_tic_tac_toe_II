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
    has_winner? || full?
  end

  def winner
    winner = false
    lines.each do |line|
      return line[0] if all_same_marks?(line)
    end
    winner
  end

  def has_winner?
    lines.any?{|line| all_same_marks?(line)}
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
    [rows, columns, diagonals].flatten(1)
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
