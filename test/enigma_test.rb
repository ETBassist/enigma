# frozen_string_literal: true

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
    assert_equal expected, @enigma.encrypt('HELLO WORLD!', '02715', '04/08/95')
  end

  def test_it_can_decrypt_text_with_given_parameters
    expected = {
      decryption: 'hello world!',
      key: '02715',
      date: '040895'
    }
    assert_equal expected, @enigma.decrypt('keder ohulw!', '02715', '04/08/95')
  end

  def test_it_can_crack_text_with_given_date
    @enigma.stubs(:force_key).returns('08304')
    expected = {
      decryption: 'hello world end',
      date: '291018',
      key: '08304'
    }
    assert_equal expected, @enigma.crack('vjqtbeaweqihssi', '291018')
  end

  def test_it_can_brute_force_key
    cracked_key = @enigma.force_key('hello world end', 'vjqtbeaweqihssi', '291018')
    assert_equal '08304', cracked_key
  end
end
