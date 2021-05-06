module CardResultHelper
  def color_of_result(result)
    if result == "Fake"
      'B00100'
    else
      '3cb371'
    end
  end
end
