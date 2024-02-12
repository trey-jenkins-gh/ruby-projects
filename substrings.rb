# https://blog.saeloun.com/2021/05/19/enumerable-tally-with-hash-argrument/

def substring(string, dictionary)
  word_hash = {}
  # string_arr = string.downcase.scan(/[[:alnum:]]+(?:[`'-][[:alnum:]]+)*/) 
  # https://stackoverflow.com/questions/44459459/using-regex-to-strip-all-characters-and-punctuation-from-a-string-except-apostro
  string_arr = string.downcase.split
  string_arr.each do |i|
    dictionary.each do |s|
      if i.include?(s)
        if word_hash.key?(s) 
          word_hash[s] += 1
        else
          word_hash[s] = 1
        end
      end
    end
  end
  word_hash
end

def deconstruct(string) # https://stackoverflow.com/questions/3059803/what-is-the-best-way-to-remove-the-last-n-characters-of-a-string-in-ruby
  string_arr = Array.new(0)
  string_clone = string.clone
  string.length.times do |l|
    string_arr.push(string_clone.reverse.slice(string_clone.length - (l + 1), string_clone.length).reverse)
  end
  string_arr
end

test_dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
test_string = "Howdy partner, sit down! How's it going?"

print substring(test_string, test_dictionary)

#print deconstruct("this")
