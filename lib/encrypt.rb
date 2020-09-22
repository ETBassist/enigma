# frozen_string_literal: true

require './lib/enigma'

message = File.open(ARGV[0], 'r')
text = message.read
message.close

enigma = Enigma.new

encoded = enigma.encrypt(text.chomp)

encrypted_file = File.open(ARGV[1], 'w')
encrypted_file.write(encoded[:encryption])
encrypted_file.close

puts "Created '#{ARGV[1]}' with the key #{encoded[:key]} and date #{encoded[:date]}"
