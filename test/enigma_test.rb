require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'

require './lib/enigma'

class EnigmaTest < MiniTest::Test
  def setup 
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_it_track_date
    Date.stubs(:today).returns(Date.new(2020,9,17))
    assert_equal "091720", @enigma.todays_date
  end

  def test_it_can_make_key
    numbers = (0..9).to_a
    @enigma.make_key.split('').each do |number|
      assert_includes numbers, number.to_i
    end
  end
end
