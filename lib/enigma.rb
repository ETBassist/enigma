require 'Date'

class Enigma
  def todays_date
    Date.today.strftime('%m%d%y')
  end

  def key_digits
    5.times.map { rand(9) }.join
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

  def shift_letters(message, shifts, default = 'forward')
    alphabet = ('a'..'z').to_a << ' '
    shifts = shifts.map(&:-@) if default != 'forward'
    message.downcase.split('').map.with_index do |character, char_index|
      if alphabet.include?(character)
        alphabet.rotate(shifts[char_index % 4])[alphabet.index(character)]
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
    alphabet = ('a'..'z').to_a << ' '
    known_characters = ['d', 'n', 'e', ' ']
    actual_characters = message.split('')[-4..-1].reverse
    shifts = actual_characters.map.with_index do |character, char_index|
      alphabet.index(character) - alphabet.index(known_characters[char_index])
    end
    decoded = shift_letters(message.reverse, shifts, 'backwards').reverse
    ordered_shifts = shifts.reverse.rotate(-message.length)
    offsets = make_offsets(date)
    key = []
    ordered_shifts.each.with_index do |shift, shift_index|
      shift -= offsets[shift_index]
        if !shift_index.zero?
          until shift.abs.digits.last == key[shift_index - 1].digits.first && shift.digits.length > 1
            shift += 27
            break if key[shift_index - 1].digits.first.zero?
          end
        end
      key << shift
    end
    key_digits = key.map do |number|
      number.digits.reverse
    end.flatten.uniq
    key_digits.unshift(0) if key_digits.length == 4
    { decryption: decoded, date: date, key: key_digits.join }
  end
end
