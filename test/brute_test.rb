require './test/test_helper'

require './lib/brute'

class BruteTest < MiniTest::Test
  def setup
    @brute = Brute.new
  end

  def test_it_can_crack_a_key
    encrypted = @brute.force_key('hello world end', 'vjqtbeaweqihssi', '291018')
    assert_equal '08304', encrypted[:key]
  end

  def test_it_can_crack_text_with_given_date
    expected = {
      decryption: 'hello world end',
      date: '291018',
      key: '08304'
    }
    assert_equal expected, @brute.crack('vjqtbeaweqihssi', '291018')
  end
end
