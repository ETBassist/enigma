require './lib/enigma'

arguments = ARGV
encrypted_filename = arguments[0]
file_to_write = arguments[1]
date = arguments[2]
encrypted_message = File.open(encrypted_filename, "r")
encrypted_text = encrypted_message.read
encrypted_message.close

enigma = Enigma.new

decoded = enigma.crack(encrypted_text, date)
decrypted_file = File.open(file_to_write, 'w')
decrypted_file.write(decoded[:decryption])
decrypted_file.close

puts "Created '#{file_to_write}' with the key #{decoded[:key]} and date #{decoded[:date]}"
