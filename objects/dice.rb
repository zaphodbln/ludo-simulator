#class dice should not be instantiated
#use SingleDice etc. instead

class Dice
  DICEMIN = 1
  DICEMAX = 6
  attr_reader :lastRoll      #lastRoll is set in specific dice class
  
  def initialize
    srand
  end
  
  def max
    DICEMAX
  end
  
  def min
    DICEMIN
  end
  
  # roll n times or until specified result is reached
  # returns the number of rolls or false, if result is not reached
  
  # eg. roll 3 times or until a 6 is rolled:
  		#SingleDice.multiple_roll(3){|u| u.lastRoll == 6}
  # eg. how long does it take to roll doubles?
        #DoubleDice.multiple_roll(100){|u| u.double?}
  def multiple_roll(n, &result_check)
    n.times do |index|
      self.roll
      return index+1 if (yield(self))
    end
    return false
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
    @lastRoll = super(val[0])
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

class DoubleDice < Dice

  attr_reader :lastRoll
  def initialize
    super
    @lastRoll = Array.new(2,0)
  end
  
  def roll(*val)
    unless val
      @lastRoll = [super, super]
    else
      @lastRoll = [super(val[0]), super(val[1])]
    end
  end
  
  def double?
    @lastRoll[0] > 0 && @lastRoll[0] == @lastRoll[1]
  end
  
end
