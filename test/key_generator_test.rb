require './test/test_helper'

require './lib/key_generator'

class KeyGeneratorTest < MiniTest::Test
  def setup
    @key_generator = KeyGenerator.new
  end

  def test_it_exists
    assert_instance_of KeyGenerator, @key_generator
  end
end
