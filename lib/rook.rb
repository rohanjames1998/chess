
class Rook

  attr_accessor :unicode

  def initialize
    @unicode = ''
  end

  def white
    unicode = "\u2656"
  end

  def black
    unicode = "\u265c"
  end
end
