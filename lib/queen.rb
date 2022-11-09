
class Queen

  attr_reader :unicode, :color

  def initialize
    @unicode = ''
    @color = ''
  end

  def white
    @unicode = "\u2655"
    @color = 'white'
  end

  def black
    @unicode ="\u265b"
    @color = 'black'
  end

end
