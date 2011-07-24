
class Field

end

class LudoField < Field
  attr_accessor :player
  
  def initialize
    @player = nil
  end
  
  def occupied?
    !@player.nil?
  end
  
  def occupied_by_player?(player)
    occupied? && player && @player.object_id == player.object_id
  end
  
  def occupied_by_opponent?(player)
    occupied? && player && @player.object_id != player.object_id
  end
end


#holds the layout of board
#does not include the actual state of the game
class Board
 def construct
 
 end
end

class LudoBoard < Board

  attr_reader(:count, :length)

  #count: number of players
  #length: length per leg, including starting point
  def construct(count, length)
    
    @count = count
    @length = length
    
    @board = Array.new(@count * @length) {LudoField.new}
    @homes = Array.new(@count * 4) {LudoField.new}
    @targets = Array.new(@count * 4) {LudoField.new}     
    
    return true
  end
  
  def field(index)
    return @board[index]
  end
  
  def fields
    return @board.length
  end
  
end
