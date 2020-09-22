# frozen_string_literal: true

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
    assert_equal '170920', @key_generator.todays_date
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

  def test_it_can_generate_offset_from_given_date
    assert_equal [1, 0, 2, 5], @key_generator.make_offsets('040895')
  end

  def test_can_generate_shifts
    keys = [2, 27, 71, 15]
    offsets = [1, 0, 2, 5]
    assert_equal [3, 27, 73, 20], @key_generator.generate_shifts(keys, offsets)
  end

  def test_can_parse_date_and_key_into_shifts
    assert_equal [3, 27, 73, 20], @key_generator.parse_inputs('02715', '040895')
  end
end
