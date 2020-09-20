require 'Date'
require './lib/key_generator'
require './lib/rotor'

class Enigma < Rotor
  def initialize
    @key_gen = KeyGenerator.new
  end

  def encrypt(message, digits = @key_gen.key_digits, date = @key_gen.todays_date)
    key = @key_gen.make_key(digits)
    offsets = @key_gen.make_offsets(date)
    shifts = @key_gen.generate_shifts(key, offsets)
    encoded = shift_letters(message, shifts)
    { encryption: encoded, key: digits, date: date }
  end

  def decrypt(message, digits, date = todays_date)
    key = @key_gen.make_key(digits)
    offsets = @key_gen.make_offsets(date)
    shifts = @key_gen.generate_shifts(key, offsets)
    decoded = shift_letters(message, shifts, 'backwards')
    { decryption: decoded, key: digits, date: date }
  end

  def crack(message, date = todays_date)
    alphabet = ('a'..'z').to_a << ' '
    known_characters = ['d', 'n', 'e', ' ']
    actual_characters = message.split('')[-4..-1].reverse
    shifts = actual_characters.map.with_index do |character, char_index|
      alphabet.index(character) - alphabet.index(known_characters[char_index])
    end
    decoded = shift_letters(message.reverse, shifts, 'backwards').reverse
    number = "00000"
    encrypted = encrypt(decoded, number, date)
    until encrypted[:encryption] == message
      number = number.next
      encrypted = encrypt(decoded, number, date)
    end
    { decryption: decoded, date: date, key: encrypted[:key] }
  end
end
