require './lib/enigma'
#require './lib/rotor'
#require './lib/key_generator'

class Brute < Enigma
  def initialize
    @key_gen = KeyGenerator.new
  end

  def force_key(decrypted_msg, encrypted_msg, date)
    number = "00000"
    encrypted = encrypt(decrypted_msg, number, date)
    until encrypted[:encryption] == encrypted_msg
      number = number.next
      encrypted = encrypt(decrypted_msg, number, date)
    end
    encrypted
  end
end
