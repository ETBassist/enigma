require './test/test_helper'

require './lib/rotor'

class RotorTest < MiniTest::Test
  def setup
    @rotor = Rotor.new
  end

  def test_it_exists
    assert_instance_of Rotor, @rotor
  end

  def test_it_can_shift_letters
    shifts = [3, 27, 73, 20]
    assert_equal 'keder ohulw!', @rotor.shift_letters('HELLO WORLD!', shifts)
    assert_equal 'hello world!', @rotor.shift_letters('keder ohulw!', shifts, 'backwards')
  end
end
