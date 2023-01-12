
class Player

  attr_accessor :name, :color, :king_loc

  def initialize
    @name = ''
    @color = ''
    @king_loc = ''
  end

  def white
    @name = get_name
    @color = 'white'
    @king_loc = '1e'
  end

  def black
    @name = get_name
    @color = 'black'
    @king_loc = '8e'
  end


  def get_name
    puts "Enter your name:"
    loop do
      name = gets.chomp.capitalize.strip
      if name.length > 10
        puts "Please enter a smaller name."
        next
      else
        return name
        break
      end
    end
  end
end
