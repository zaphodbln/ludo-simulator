$:.unshift File.join(File.dirname(__FILE__),"..","objects")
require 'test/unit'
require 'dice'

class TestSingleDice < Test::Unit::TestCase
  def test_min_max
    testDice = SingleDice.new
    
    assert(testDice.min < testDice.max, "min should be less than max")
  end
  
  def test_test
    testDice = SingleDice.new
    testlength = 100000
    testArray = testDice.test(testlength)
    probability = 1 / (testDice.max - testDice.min + 1).to_f
    threshold = [testlength * (probability-0.005), testlength * (probability+0.005)]
    #puts threshold[0].to_s + " " + threshold[1].to_s
    
    assert_equal(testArray.inject(0){|sum, u| sum = sum + u}, testlength)
    assert_equal(testArray.length, testDice.max - testDice.min + 1)
    testArray.each do |val|
      assert(val.between?(threshold[0],threshold[1]), "random generator should be improved: #{val.to_s}")
    end
  end
  
  def test_roll
    testDice = SingleDice.new
    20.times do
      val = testDice.roll
      assert(val.between?(testDice.min, testDice.max), "should roll between #{testDice.min} and #{testDice.max}, rolled #{val}")
    end
  end
end
