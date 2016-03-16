class Board
  attr_reader :grid, :dimension

  def initialize(marks = (0..8).to_a)
    @grid = marks
    @dimension = Math.sqrt(@grid.size).to_i
  end

  def add_mark(position, mark)
    new_grid = grid.clone
    new_grid[position] = mark
    return Board.new(new_grid)
  end

  def available_positions
    positions = []
    grid.each do |cell|
      if (0..8).to_a.include? cell
        positions << cell
      end
    end
    positions
  end

  def game_over?
    winner || full? ? true : false
  end

  def winner
    winner = false
    lines.each do |line|
      winner = :X if all_x(line)
      winner = :O if all_o(line)
    end
    winner
  end

  def empty?
    !full?
  end

  def full?
    (grid & (0..8).to_a).empty?
  end

  def all_x(line)
    line.all? {|x| x == :X}
  end

  def all_o(line)
    line.all? {|o| o == :O}
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

