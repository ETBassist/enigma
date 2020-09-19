require 'Date'

class Enigma
  def todays_date
    Date.today.strftime('%m%d%y')
  end

  def key_digits
    (0..9).to_a.sample(5).join
  end

  def make_key(digits)
    digits.split('').each_cons(2).map do |pair|
      pair.join.to_i
    end
  end

  def make_offsets(date)
    squared_date = date.to_i**2
    squared_date.digits.reverse[-4..-1]
  end

  def generate_shifts(key, offsets)
    key.zip(offsets).map(&:sum)
  end

  def encrypt(message, digits = key_digits, date = todays_date)
    alphabet = ('a'..'z').to_a << ' '
    shifts = generate_shifts(make_key(digits), make_offsets(date))
    encoded = message.split('').map.with_index do |character, character_index|
      if alphabet.include?(character)
        alphabet.rotate(shifts[character_index % 4])[alphabet.index(character)]
      else
        character
      end
    end.join
    { encryption: encoded, key: digits, date: date }
  end

  def decrypt(message, digits, date = todays_date)
    alphabet = ('a'..'z').to_a << ' '
    shifts = generate_shifts(make_key(digits), make_offsets(date))
    decoded = message.split('').map.with_index do |character, character_index|
      if alphabet.include?(character)
        alphabet.rotate(-shifts[character_index % 4])[alphabet.index(character)]
      else
        character
      end
    end.join
    { decryption: decoded, key: digits, date: date }
  end
end
