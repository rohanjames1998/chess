
class King

  attr_reader :unicode, :color

  def initialize
    @unicode = ''
    @color = ''
  end

  def white
    @unicode = "\u2654"
    @color = 'white'
  end

  def black
    @unicode = "\u265a"
    @color = 'black'
  end

end
