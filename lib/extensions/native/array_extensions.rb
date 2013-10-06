class Array

  def average
    sum / size
  rescue ZeroDivisionError
    nil
  end

end