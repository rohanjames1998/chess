
class Knight

attr_reader :unicode, :color

  def initialize
    @unicode = ''
    @color = ''
  end

  def white
    @unicode = "\u2658"
    @color = 'white'
  end

  def black
    @unicode = "\u265e"
    @color = 'black'
  end

end
