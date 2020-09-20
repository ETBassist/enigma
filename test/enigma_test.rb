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

  def test_it_can_encrypt_text_with_given_parameters
    expected = {
      encryption: 'keder ohulw!',
      key: '02715',
      date: '040895'
    }
    assert_equal expected, @enigma.encrypt('HELLO WORLD!', '02715', '040895')
  end

  def test_it_can_decrypt_text_with_given_parameters
    expected = {
      decryption: 'hello world!',
      key: '02715',
      date: '040895'
    }
    assert_equal expected, @enigma.decrypt('keder ohulw!', '02715', '040895')
  end

  def test_it_can_crack_text_with_given_date
    expected = {
      decryption: 'hello world end',
      date: '291018',
      key: '08304'
    }
    assert_equal expected, @enigma.crack('vjqtbeaweqihssi', '291018')
  end

  def test_it_can_shift_letters
    shifts = [3, 27, 73, 20]
    assert_equal 'keder ohulw!', @enigma.shift_letters('HELLO WORLD!', shifts)
    assert_equal 'hello world!', @enigma.shift_letters('keder ohulw!', shifts, 'backwards')
  end
end
