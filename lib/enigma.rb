require 'Date'

class Enigma

  def todays_date
    Date.today.strftime("%m%d%y")
  end

  def key_digits
    (0..9).to_a.sample(5).join
  end
end
