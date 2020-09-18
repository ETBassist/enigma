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
end
