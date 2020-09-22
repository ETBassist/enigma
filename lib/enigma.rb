# frozen_string_literal: true

require './lib/key_generator'
require './lib/rotor'

# Contains logic for how characters are to be shifted
class Enigma < Rotor
  def initialize
    super()
    @key_gen = KeyGenerator.new
  end

  def encrypt(message, digits = @key_gen.key_digits, date = @key_gen.todays_date)
    shifts = @key_gen.parse_inputs(digits, date)
    encoded_message = shift_letters(message, shifts)
    { encryption: encoded_message, key: digits, date: date.delete('/') }
  end

  def decrypt(message, digits, date = @key_gen.todays_date)
    shifts = @key_gen.parse_inputs(digits, date)
    decoded_message = shift_letters(message, shifts, 'backwards')
    { decryption: decoded_message, key: digits, date: date.delete('/') }
  end

  def crack(message, date = @key_gen.todays_date)
    known_characters = ['d', 'n', 'e', ' ']
    actual_characters = message.split('')[-4..-1].reverse
    shifts = actual_characters.map.with_index do |character, char_index|
      @alphabet.index(character) - @alphabet.index(known_characters[char_index])
    end
    decoded = shift_letters(message.reverse, shifts, 'backwards').reverse
    cracked_key = force_key(decoded, message, date)
    { decryption: decoded, date: date, key: cracked_key }
  end

  def force_key(decrypted_msg, encrypted_msg, date)
    number = '00000'
    encrypted = encrypt(decrypted_msg, number, date)
    until encrypted[:encryption] == encrypted_msg
      number = number.next
      encrypted = encrypt(decrypted_msg, number, date)
    end
    encrypted[:key]
  end
end
