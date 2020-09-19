require './test/test_helper'
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
    Date.stubs(:today).returns(Date.new(2020, 9, 17))
    assert_equal '091720', @enigma.todays_date
  end

  def test_it_can_make_key_digits
    numbers = (0..9).to_a
    @enigma.key_digits.split('').each do |number|
      assert_includes numbers, number.to_i
    end
  end

  def test_can_make_key_from_given_digits
    assert_equal [24, 46, 68, 80], @enigma.make_key('24680')
  end

  def test_it_can_generate_offset_from_given_date
    assert_equal [1, 0, 2, 5], @enigma.make_offsets('040895')
  end

  def test_can_generate_shifts
    keys = [2, 27, 71, 15]
    offsets = [1, 0, 2, 5]
    assert_equal [3, 27, 73, 20], @enigma.generate_shifts(keys, offsets)
  end

  def test_it_can_encrypt_text_with_given_parameters
    expected = {
      encryption: "keder ohulw!",
      key: "02715",
      date: "040895"
    }
    assert_equal expected, @enigma.encrypt("hello world!", "02715", "040895")
  end

  def test_it_can_decrypt_text_with_given_parameters
    expected = {
      decryption: "hello world!",
      key: "02715",
      date: "040895"
    }
    assert_equal expected, @enigma.decrypt("keder ohulw!", "02715", "040895")
  end
 
  def test_it_can_crack_text_with_given_date
    expected = {
      decryption: "hello world end",
      date: "291018",
      key: "08304"
    }
    assert_equal expected, @enigma.crack("vjqtbeaweqihssi", "291018")
  end
end
