
class Rook

  attr_reader :unicode, :color

  def initialize
    @unicode = ''
    @color = ''
  end

  def white
    @unicode = "\u2656"
    @color = 'white'
  end

  def black
    @unicode = "\u265c"
    @color = 'black'
  end
end
