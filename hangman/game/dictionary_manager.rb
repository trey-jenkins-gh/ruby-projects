
class Dictionary

  def get_dictionary
    dictionary = File.foreach('dictionary.txt').flat_map{|line| line.split(' ')}
    return dictionary
  end

  def filter(dictionary)
    filter_array = Array.new
    dictionary.each do |word|
      if word.length < 5 && word.length < 13
        next
        print 'skipped'
      else
        filter_array.push(word)
      end
    end
    return filter_array
  end

  def output_word
    secret = (filter(get_dictionary)).sample.upcase.split('')
    return secret
  end
end

# full_dictionary = File.open('./dictionary.txt').flat_map{ |line| line.split }
# test = Dictionary.new
# test.output_word
