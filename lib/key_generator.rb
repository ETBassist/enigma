class KeyGenerator
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
end
