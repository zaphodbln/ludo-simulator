$:.unshift File.join(File.dirname(__FILE__),"..","objects")
require 'test/unit'
require 'board'

class TestLudoBoard < Test::Unit::TestCase
  def test_construct
    testBoard = LudoBoard.new
    testBoard.construct(4,10)
    
    assert_equal(testBoard.length, 10)
    assert_equal(testBoard.count, 4)
    assert_equal(testBoard.fields, 40)
    assert_instance_of(LudoField, testBoard.field(1))
  end  
end

class TestLudoField < Test::Unit::TestCase
  def test_field
    testField = LudoField.new
    testPlayer1 = Object.new    #you may insert every class here - just did it to avoid including the player class
    testPlayer2 = Object.new
    
    assert !testField.occupied?
    testField.player = testPlayer1
    assert testField.occupied?
    assert testField.occupied_by_player?(testPlayer1)
    assert !testField.occupied_by_opponent?(testPlayer1)
    assert !testField.occupied_by_player?(testPlayer2)
    assert testField.occupied_by_opponent?(testPlayer2)
  end
end
