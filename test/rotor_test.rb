require './test/test_helper'

require './lib/rotor'

class RotorTest < MiniTest::Test
  def setup
    @rotor = Rotor.new
  end

  def test_it_exists
    assert_instance_of Rotor, @rotor
  end
end
