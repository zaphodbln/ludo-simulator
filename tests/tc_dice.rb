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
    testlength = 10000
    testArray = testDice.test(testlength)
    probability = 1 / (testDice.max - testDice.min + 1).to_f
    threshold = [testlength * (probability * 0.90), testlength * (probability * 1.1)].map{|u| u = u.to_i}
    
    assert_equal(testArray.inject(0){|sum, u| sum = sum + u}, testlength)
    assert_equal(testArray.length, testDice.max - testDice.min + 1)
    testArray.each do |val|
      assert(val.between?(threshold[0],threshold[1]), "random generator should be improved. Interval should be between #{threshold[0]} and #{threshold[1]}, got #{val.to_s}")
    end
  end
  
  def test_roll
    testDice = SingleDice.new
    20.times do
      val = testDice.roll
      assert(val.between?(testDice.min, testDice.max), "should roll between #{testDice.min} and #{testDice.max}, rolled #{val}")
      assert_equal(val, testDice.lastRoll)
    end
  end
  
  def test_multiple_roll
    testDice = SingleDice.new
    
    assert_equal 1, testDice.multiple_roll(3){|u| u.lastRoll.between?(testDice.min, testDice.max)}
    assert !testDice.multiple_roll(30){|u| u.lastRoll > testDice.max}
  end
end

class TestDoubleDice < Test::Unit::TestCase
  def test_roll
    testDice = DoubleDice.new
    20.times do
      val = testDice.roll
      assert(val[0].between?(testDice.min, testDice.max), "should roll between #{testDice.min} and #{testDice.max}, rolled #{val[0]}")
      assert(val[1].between?(testDice.min, testDice.max), "should roll between #{testDice.min} and #{testDice.max}, rolled #{val[1]}")
    end
  end
  
  def test_double
    testDice = DoubleDice.new
    
    testDice.roll(1,2)
    assert  !testDice.double?
    
    testDice.roll(2,2)
    assert testDice.double?
    
    testDice.roll(2,3)
    assert !testDice.double?
  end
  
  def test_mass_double
    testDice = DoubleDice.new
    testLength = 20000
    threshold = ((testLength / (1 + testDice.max - testDice.min )) * 0.95).to_i
    dump_double = 0
    dump_seven = 0
    
    testLength.times do
      val = testDice.roll
      dump_double = dump_double + 1 if testDice.double?  
      dump_seven = dump_seven + 1 if val[0] + val[1] == 7  
    end

    assert(dump_double > threshold, "did not roll enough doubles: rolled #{dump_double}, but should roll #{threshold}")
    assert(dump_seven > threshold, "did not roll enough sevens: rolled #{dump_seven}, but should roll #{threshold}")  
  end
  
  def test_multiple_roll
    testDice = DoubleDice.new
    
    assert testDice.multiple_roll(100) {|u| u.double?}, "did not role any double"
    assert !testDice.multiple_roll(100) {|u| u.lastRoll[0] > 6}
  end
end
