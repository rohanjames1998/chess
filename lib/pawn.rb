
class Pawn

  attr_accessor :unicode

  def initialize
    @unicode = ''
  end

  def white
    unicode = "\u2659"
  end

  def black
    unicode = "\u265f"
  end

end
