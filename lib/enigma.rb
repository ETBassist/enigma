require 'Date'
require './lib/key_generator'

class Enigma < KeyGenerator
  def initialize
    @alphabet = ('a'..'z').to_a << ' '
  end

  def shift_letters(message, shifts, default = 'forward')
    shifts = shifts.map(&:-@) if default != 'forward'
    split_message = message.downcase.split('')
    split_message.map.with_index do |character, char_index|
      if @alphabet.include?(character)
        @alphabet.rotate(shifts[char_index % 4])[@alphabet.index(character)]
      else
        character
      end
    end.join
  end

  def encrypt(message, digits = key_digits, date = todays_date)
    shifts = generate_shifts(make_key(digits), make_offsets(date))
    encoded = shift_letters(message, shifts)
    { encryption: encoded, key: digits, date: date }
  end

  def decrypt(message, digits, date = todays_date)
    shifts = generate_shifts(make_key(digits), make_offsets(date))
    decoded = shift_letters(message, shifts, 'backwards')
    { decryption: decoded, key: digits, date: date }
  end

  def crack(message, date = todays_date)
    known_characters = ['d', 'n', 'e', ' ']
    actual_characters = message.split('')[-4..-1].reverse
    shifts = actual_characters.map.with_index do |character, char_index|
      @alphabet.index(character) - @alphabet.index(known_characters[char_index])
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
