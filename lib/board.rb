class Board

  def initialize(marks = [:E]*9)
    @grid = marks
    @dimension = Math.sqrt(@grid.size).to_i
  end

  def winner
    winner = false
    lines.each do |line|
      if all_x(line)
        winner = :X
      end

      if all_o(line)
        winner = :O
      end
    end
    winner
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

  def empty?
    full? == false
  end

  def full?
    @grid.each do |mark|
      if mark == :E
        return false
      end
    end
    true
  end

  def lines
    [rows, columns, diagonals].flatten(1)
  end

  def rows
    rows = []
    @grid.each_slice(@dimension) do |row|
      rows << row
    end
    rows
  end

  def columns
    columns = []
    index = 0
    @dimension.times do
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
    @dimension.times do
      first << @grid[(@dimension * index) + index]
      index +=1
    end

    second = []
    offset = @dimension-1
    @dimension.times do
      second << @grid[offset]
      offset += @dimension-1
    end
    [first, second]
  end

end

