require 'Date'

class Enigma
  def todays_date
    Date.today.strftime('%m%d%y')
  end

  def key_digits
    digits = []
    5.times do 
      digits << rand(9)
    end
    digits.join
  end

  def make_key(digits)
    digits.split('').each_cons(2).map do |pair|
      pair.join.to_i
    end
  end

  def make_offsets(date)
    (date.to_i**2).digits.reverse[-4..-1]
  end

  def generate_shifts(key, offsets)
    key.zip(offsets).map(&:sum)
  end

  def encrypt(message, digits = key_digits, date = todays_date)
    alphabet = ('a'..'z').to_a << ' '
    shifts = generate_shifts(make_key(digits), make_offsets(date))
    encoded = message.downcase.split('').map.with_index do |character, char_index|
      if alphabet.include?(character)
        alphabet.rotate(shifts[char_index % 4])[alphabet.index(character)]
      else
        character
      end
    end.join
    { encryption: encoded, key: digits, date: date }
  end

  def decrypt(message, digits, date = todays_date)
    alphabet = ('a'..'z').to_a << ' '
    shifts = generate_shifts(make_key(digits), make_offsets(date))
    decoded = message.split('').map.with_index do |character, char_index|
      if alphabet.include?(character)
        alphabet.rotate(-shifts[char_index % 4])[alphabet.index(character)]
      else
        character
      end
    end.join
    { decryption: decoded, key: digits, date: date }
  end

  def crack(message, date = todays_date)
    alphabet = ('a'..'z').to_a << ' '
    known_characters = ['d', 'n', 'e', ' ']
    make_offsets(date)
  end
# possible generation of key from cracked digits
# keys = [2, 27, 71, 15]
# digits = keys.flat_map.with_index do |key, key_index|
#   if key_index != 0
#      until key.digits.last == keys[key_index - 1].digits.first
#         key += shifts[key_index]
#      end
#      key.digits.reverse
# end.uniq
#=> [2, 7, 1, 5]
end
