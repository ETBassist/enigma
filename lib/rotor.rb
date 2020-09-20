class Rotor
  def shift_letters(message, shifts, default = 'forward')
    alphabet = ('a'..'z').to_a << ' '
    shifts = shifts.map(&:-@) if default != 'forward'
    split_message = message.downcase.split('')
    split_message.map.with_index do |character, char_index|
      if alphabet.include?(character)
        alphabet.rotate(shifts[char_index % 4])[alphabet.index(character)]
      else
        character
      end
    end.join
  end
end
