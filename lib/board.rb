class Board

  def initialize(marks = [:E]*9)
    @grid = marks
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

end

