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
    alphabet = ("a".."z").to_a << " "
    key = make_key(digits)
    offset = make_offsets(date)
    shifts = generate_shifts(key, offset)
    counter = 0
    # figure out how to refactor using with_index later
    encoded = message.split('').map do |character|
      counter += 1
      if counter == 1
        alphabet.rotate(shifts[0])[alphabet.index(character)]
      elsif counter == 2
        alphabet.rotate(shifts[1])[alphabet.index(character)]
      elsif counter == 3
        alphabet.rotate(shifts[2])[alphabet.index(character)]
      else
        counter = 0
        alphabet.rotate(shifts[3])[alphabet.index(character)]
      end
    end.join
    { encryption: encoded, key: digits, date: date }
  end
end
