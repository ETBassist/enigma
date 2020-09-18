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
end
