class KeyGenerator
  def todays_date
    Date.today.strftime('%m%d%y')
  end

  def key_digits
    5.times.map { rand(9) }.join
  end
end
