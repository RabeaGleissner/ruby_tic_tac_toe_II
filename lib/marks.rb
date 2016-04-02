module Marks
  X = :X
  O = :O

  def switch_mark(mark)
    mark = mark == X ? O : X
  end

end
