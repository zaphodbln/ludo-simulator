require 'singleton'
class Dice
  include Singleton
  DICEMIN = 1
  DICEMAX = 6
  
  def initialize
    srand
  end
  
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
