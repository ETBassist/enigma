require 'Date'

class KeyGenerator
  def todays_date
    Date.today.strftime('%d%m%y')
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
end
