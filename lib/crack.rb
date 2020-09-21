# frozen_string_literal: true

require './lib/enigma'

encrypted_message = File.open(ARGV[0], 'r')
encrypted_text = encrypted_message.read
encrypted_message.close

enigma = Enigma.new

decoded = enigma.crack(encrypted_text, ARGV[2])
decrypted_file = File.open(ARGV[1], 'w')
decrypted_file.write(decoded[:decryption])
decrypted_file.close

puts "Created '#{ARGV[0]}' with the cracked key #{decoded[:key]} and date #{decoded[:date]}"
