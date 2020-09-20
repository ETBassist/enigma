require './test/test_helper'

require './lib/key_generator'
require 'mocha/minitest'

class KeyGeneratorTest < MiniTest::Test
  def setup
    @key_generator = KeyGenerator.new
  end

  def test_it_exists
    assert_instance_of KeyGenerator, @key_generator
  end

  def test_it_tracks_date
    Date.stubs(:today).returns(Date.new(2020, 9, 17))
    assert_equal '091720', @key_generator.todays_date
  end

  def test_it_can_make_key_digits
    numbers = (0..9).to_a
    @key_generator.key_digits.split('').each do |number|
      assert_includes numbers, number.to_i
    end
  end

  def test_can_make_key_from_given_digits
    assert_equal [24, 46, 68, 80], @key_generator.make_key('24680')
  end
end
