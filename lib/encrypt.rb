require './lib/enigma'

# ARGV saves additional arguments given from command line as an array
ARGV

message = File.open(ARGV[0], "r")

text = message.read

message.close

enigma = Enigma.new

encoded = enigma.encrypt(text.chomp)

encrypted_file = File.open('encrypted.txt', 'w')
encrypted_file.write(encoded[:encryption])
encrypted_file.close

puts "Created 'encrypted.txt' with the key #{encoded[:key]} and date #{encoded[:date]}"
