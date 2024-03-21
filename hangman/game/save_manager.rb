# This code would not exist without https://www.youtube.com/@self_taught_dev
module SaveManager

  def load_game
    if File.exist?('./saves')
      puts "Saved Games: #{Dir.children('./saves').join('\n')}"

      puts "Which file name would you like to load? (Don't worry about adding .yml!)"
      file = gets.chomp
      load_from_yml("#{file}")
    else
      puts "No loadable files were found."
      load_save
    end
  end

  def save_to_yml(filename)
    Dir.mkdir('./saves') unless File.exist?('./saves')
    b = File.open("./saves/#{filename}.yml", 'w')
    YAML.dump({
      :word => @word,
      :incorrect_guesses => @incorrect_guesses,
      :incorrect_count => @incorrect_count,
      :correct_guesses => @correct_guesses,
      :guess_history => @guess_history
    }, b)
    b.close
    puts "Game has been saved!"
  end

  def load_from_yml(filename)
    b = YAML.load(File.read("./saves/#{filename}.yml"))
    @word              = b[:word]
    @incorrect_guesses = b[:incorrect_guesses]
    @incorrect_count   = b[:incorrect_count]
    @correct_guesses   = b[:correct_guesses]
    @guess_history     = b[:guess_history]
  end
end
