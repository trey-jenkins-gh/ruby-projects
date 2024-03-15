require_relative 'player.rb'
require_relative 'utils.rb'
require_relative 'board.rb'
require_relative 'utils.rb'

class GameManager

  def initialize
    @password = []
    @guess = []

    @matches = 0
    @closes = 0

    @turn = 11

    @win = false

    @board = Board.new

    @io_manager = InputManager.new
  end

  def play
    choose_role
    system ('clear')
    @player_1.role_desc
    @password = set_password
    @player_2.role_desc
    while @win != true
      @guess = set_guess
      @board.draw(check_guess_input, @turn)
      check_win
    end
    play_again
  end

  def choose_role
    print "\nPlayer, please input which role you would like to take:\n1) Code Maker\n2) Code Breaker\n"
    role = gets.chomp.to_i
    if role == 1
      @player_1 = create_maker
      @player_2 = create_breaker
    elsif role == 2
      @player_2 = create_breaker
      @player_1 = create_maker
    else
      print "Please give a valid selection."
      choose_role
    end
  end

  def create_maker
    puts "Enter a name for the Code Maker: Press <Enter> to play the CPU\n"
    name = gets.chomp
    case name
    when  ""
      player_1 = CPU.new
    else
      player_1 = Maker.new(name: name)
    end
    player_1
  end

  def set_password
    case @player_1.name
    when "CPU"
      @io_manager.cpu_password_input
    else
      @io_manager.player_password_input
    end
  end

  def create_breaker
    puts "Enter a name for the Code Breaker: Press <Enter> to play the CPU\n"
    name = gets.chomp
    if name == ""
      player_2 = CPU.new
    else
      player_2 = Breaker.new(name: name)
    end
    return player_2
  end

  def set_guess
    case @player_2.role
    when "CPU"
      return @io_manager.cpu_guess_input
      sleep 2
    else
      return @io_manager.player_guess_input
    end
  end

  def check_guess_input
    @password.each_with_index do |pv, pi|
      @guess.each_with_index do |gv, gi|
        if pv == gv && pi == gi
          @matches += 1
        elsif pv == gv && pi != gi
          @closes += 1
        end
      end
    end
    build_grade
  end

  def build_grade
    grade = []
    @matches.times {grade << "O"}
    @closes.times {grade << "W"}
    return grade
  end

  def clear_guess
    @turn   -= 1
    @matches = 0
    @closes  = 0
  end

  def check_win
    if @matches == 4
      @win = true
      end_game_message(@win)
    elsif @turn == 0
      end_game_message(@turn)
    else
      clear_guess
    end
  end

  def end_game_message(value = false)
    if value == true
      print "\n\nThe Code Breaker has cracked the code! #{@player_2.name} wins!\n\n"

    elsif @turn == 0
      print "\n\nThe Coke Maker has created an unsolvable code! #{@player_1.name} wins!\n\n"
      print "The password was #{@password}!\n"
    else
      value
    end
  end

  def play_again
    print "Play again? [y/n]\n"
    input = gets.chomp
    if input == 'Y' || input == 'y'
      play
    else
      exit
    end
  end
end

game = GameManager.new
game.play
