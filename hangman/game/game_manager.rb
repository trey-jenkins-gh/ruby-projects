require_relative 'dictionary_manager.rb'
require_relative 'save_manager.rb'
require_relative 'board_manager.rb'
require 'yaml'

class GameManager
  include SaveManager
  attr_reader :word, :incorrect_guesses, :correct_guesses, :incorrect_count
  def initialize(args={})
    @word = Dictionary.new.output_word
    @incorrect_guesses = Array.new(6, "_")
    @incorrect_count = 0
    @correct_guesses = Array.new(@word.length, "_")
    @guess_history = []
    @board = BoardManager.new(@incorrect_count)
    @win = nil
    load_save
  end

  def play
      print "#{@word.join('')}\n"
    while @win == nil
      @board.print_board(@incorrect_count)
      word_status
      win_lose
      guess
    end
  end

  def load_save
    print "Would you like to load a previous game?\n[Y/N]"
    input = gets.chomp.upcase
    if input == "Y"
      load_game#------------------------------------------------
      play
    else
      play
    end
  end

  def guess
    puts "What would you like to guess? Enter 'save' to save the game for later.\n"
    input = gets.chomp.upcase
    check_guess(input)
  end

  def check_valid_input?(input)
    if input.length == 1 && input.match?(/[A-Z]/)
      return true
    elsif input.upcase == "SAVE"  #-----------------------------------------------------
      save_game
    elsif input.upcase == "LOAD"
      load_game #------------------------------------------------
    else
      print "Please enter a single letter to guess.\n"
      word_status
      guess
    end
  end

  def save_game
    print "What would you like to call the save?"
    input = gets.chomp
    save_to_yml(input)
  end

  def check_guess(input)
    if check_valid_input?(input)
        if @guess_history.include?(input)
        print "Letter has already been used!\n"
        @board.print_board(@incorrect_count)
        word_status
        guess
      elsif @word.include?(input) # restructur inside if statement
          @word.each_with_index do |letter, index|
          if input == letter
            @correct_guesses[index] = letter
            @guess_history << letter
          end
        end
      else
        @guess_history << input
        @incorrect_guesses.unshift(input).pop
        @incorrect_count += 1
        @board.print_board(@incorrect_count)
        word_status
        win_lose
        guess
      end
    end
  end

  def word_status
    print "   WORD: #{@correct_guesses.join(' ')}            Misses: #{@incorrect_guesses.join(' ')}\n\n"
  end

  def win_lose
    if @incorrect_count == 6
      @win = 'Loser!'
      print "#{@win} The Hangman was hung because of the word #{@word.join('')}!\n"
      replay?
    elsif !@correct_guesses.include?('_')
      @win = 'Winner!'
      print "#{@win} You saved the Hangman! The word was #{@word.join}!\n"
      replay?
    end
  end

  def replay?
    print "Would you like to go again? [Y/N]\n"
    input = gets.chomp.upcase
    if input == 'Y'
      initialize
      play
    else
      exit
    end
  end
end


test = GameManager.new
test.play
