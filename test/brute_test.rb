require './test/test_helper'

require './lib/brute'

class BruteTest < MiniTest::Test
  def test_it_can_crack_a_key
    brute = Brute.new
    encrypted = brute.force_key('hello world end', 'vjqtbeaweqihssi', '291018')
    assert_equal '08304', encrypted[:key]
  end
end
