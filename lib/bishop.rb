
class Bishop

  attr_reader :unicode, :color

  def initialize
    @unicode = ''
    @color = ''
  end

  def white
    @unicode = "\u2657"
    @color = 'white'
  end

  def black
    @unicode = "\u265d"
    @color = 'black'
  end

end
