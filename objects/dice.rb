class Dice
  DICEMIN = 1
  DICEMAX = 6
  
  def initialize
    srand
  end
  
  def max
    DICEMAX
  end
  
  def min
    DICEMIN
  end
  
  protected
  def roll(*val)
    unless val[0]
      return DICEMIN + (rand * (1 + DICEMAX - DICEMIN) ).to_i
    end
    if val[0] && val[0].between?(DICEMIN, DICEMAX) 
      return val[0]
    else 
      throw 'domain error'
    end
  end
end

class SingleDice < Dice
  
  def roll(*val)
    super(val[0])
  end
  
  def test(count)
    retVal = Array.new(1 + DICEMAX - DICEMIN, 0)
    count.times do 
      val = roll - 1
      retVal[val] = retVal[val] + 1
    end
    return retVal
  end 
end
