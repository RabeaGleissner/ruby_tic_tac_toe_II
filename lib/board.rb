class Board
  attr_reader :grid, :dimension

  def initialize(marks = [nil]*9)
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
    index = 0
    grid.each do |cell|
      if cell == nil
        positions << index
      end
      index += 1
    end
    positions
  end

  def game_over?
    return true if winner || full?
    false
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
    full? == false
  end

  def full?
    grid.each do |mark|
      return false if mark == nil
    end
    true
  end

  def all_x(line)
    all_x = true
    line.each do |cell|
      all_x = all_x && cell == :X
    end
    all_x
  end

  def all_o(line)
    all_o = true
    line.each do |cell|
      all_o = all_o && cell == :O
    end
    all_o
  end

  def lines
    [rows, columns, diagonals].flatten(1)
  end

  def rows
    rows = []
    grid.each_slice(dimension) do |row|
      rows << row
    end
    rows
  end

  def columns
    columns = []
    index = 0
    dimension.times do
      column = []
      rows.each do |row|
        column << row[index]
      end
      columns << column
      index += 1
    end
    columns
  end

  def diagonals
    first = []
    index = 0
    dimension.times do
      first << grid[(dimension * index) + index]
      index +=1
    end

    second = []
    offset = dimension-1
    dimension.times do
      second << grid[offset]
      offset += dimension-1
    end
    [first, second]
  end

end

