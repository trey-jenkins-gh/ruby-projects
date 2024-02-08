# Caeser Cypher - https://stackoverflow.com/questions/41338764/ruby-caesar-cipher-explanation
def encrypt(string, shift = rand(1..15)) # set the shift to have a random default if a number isn't provided

  low_case = ('a'..'z').to_a.join # lower case reference
  high_case = ('A'..'Z').to_a.join # upper case reference
  # print "low_case: #{low_case}\nhigh_case: #{high_case}\n"

  enc_low = low_case.chars.rotate(shift).join # shifting over lower case letters by the cypher key
  enc_high = high_case.chars.rotate(shift).join # shifting over upper case letters by the cypher key
  # print "enc_low #{enc_low}\nenc_high: #{enc_high}\n"

  string.tr(low_case + high_case, enc_low + enc_high) # trimming (replacing) letters with shifted letters

end
