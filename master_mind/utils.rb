class InputManager
require 'io/console'

  def input_message
    print "\nPlease input 4 numbers (1-6). No duplicates are allowed.\nPress <Enter> when you are done.\n"
  end

  def player_guess_input
    input_message
    guess = input_to_i_array(gets.chomp) # getting input from human breaker
    check_input(guess) == true ? guess : player_guess_input
  end

  def player_password_input
    input_message
    password = input_to_i_array(STDIN.noecho(&:gets).chomp) # getting and hiding input from human maker
    check_input(password) == true ? password : player_password_input
  end

  def cpu_password_input
    choices_arr = ['1', '2', '3', '4', '5', '6']
    password = input_to_i_array(choices_arr.sample(4).join) # getting and hiding input from human maker
    cpu_check_input(password) == true ? password : cpu_password_input
  end

  def cpu_guess_input
    choices_arr = ['1', '2', '3', '4', '5', '6']
    cpu_guess = input_to_i_array(choices_arr.sample(4).join) # getting and hiding input from human maker
    cpu_check_input(cpu_guess) == true ? cpu_guess : cpu_guess_input
  end

  def input_to_i_array(string) # converting input into an array
    input_array = string.split('').map(&:to_i)
    return input_array
  end

  def check_input(input_array) # checking that input array is valid
    is_valid = false
    if input_array.length < 4 # not enough input digits
      puts "\n\nNot enough digits given.\n\n"
    elsif input_array.max > 6 || input_array.min < 1 # out of range digits
      puts "\n\nOnly numbers 1, 2, 3, 4, 5, 6 are accepted.\n\n"
    elsif input_array.uniq.length > 4
      puts "\n\nOnly use 4 digits for input."
    else
    is_valid = true
    end
  end

  def cpu_check_input(input_array) # checking that input array is valid
    is_valid = false
    if input_array.length < 4 # not enough input digits
      is_valid
    elsif input_array.max > 6 || input_array.min < 1 # out of range digits
      is_valid
    elsif input_array.uniq.length < 4
      is_valid
    else
    is_valid = true
    end
  end
end

test = InputManager.new
# print test.cpu_password_input
