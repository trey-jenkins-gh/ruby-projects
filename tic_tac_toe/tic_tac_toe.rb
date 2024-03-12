# frozen_string_literal: true

# Rules of the Project:
# Build a tic-tac-toe game on the command line where 2 (human) players can
#  play against each other, and the board is displayed between turns.

# Rules of the Game:
# Each player places their symbol on a 3x3 board in turns. The game ends
#  when one player has their symbol in a line of 3 (vertical, horizontal,
#  diagonal) or no other moves can be made.

# The Abstract:
# The board is numbered (from top right) 1-9, players place their symbol
#  to make a combination of 3 numbers to win (1,2,3 or 3,6,9 or 1,5,9 etc.)

#  The board must be drawn at game start and after each symbol is placed.
#  A METHOD should check that the symbol placement is valid (not already taken).

#  The winning combinations could be kept in an array of arrays.
#  After each symbol is placed, a METHOD to check for win/draw condition should run.
#  The players symbol placement should be contain in an array and checked against
#  the winning combinations array array. No matches for either player is a draw.

#  After Win/Draw the player should be prompted to play again, or terminate.

# Step 1: Build the board



# Prototype for the GameManager Class - In idea, the manager will run the game, e.g. keep track of the "claimed space" array, call the board to be drawn, manage "running/win/draw" states.
class GameManager
  WIN_MATCHES = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], #vertical
    [0, 3, 6], [1, 4, 7], [2, 5, 8], #horizontal
    [0, 4, 8], [2, 4, 6] #diagonal
  ]

  attr_accessor :game_array, :current_player
  attr_reader :game_end

  def initialize(args={})
    @game_array = args[:game_array] || [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @game_end   = args[:game_end] || false
    @current_player = args[:current_player] || "X"
  end

  def play
    while @game_end == false
      build_board
      win_draw?
      place_sym
      switch_player
    end
  end

  def build_board
    puts
    seperator = "---+---+---\n"
    game_array.each_with_index do |value, index|
      if ((index + 1) % 3).zero?
        print " #{value} \n"
        print seperator if (index + 1) < 9
      else
        print " #{value} |"
      end
    end

  end

  def switch_player
    win_draw?
    if game_end == false
      case @current_player
        when "X"
          then @current_player = "O"
        when "O"
          then @current_player = "X"
      end
      puts "\nIt is Player #{current_player}'s turn.\n"
    end
  end

  def place_sym
    puts "\nWhere would you like to place your piece?"

    input = gets.chomp
    if game_array[input.to_i - 1].class == String
      print "That position is not available!\n"
      place_sym
    elsif input.to_i.between?(1, 9)
      input = input.to_i
      game_array[input - 1] = current_player
    end
  end

  def game_over
    game_end = true
    build_board
    exit
  end

  def win_draw?
    WIN_MATCHES.each do |combo|
      if game_array.values_at(*combo) == %w(X X X)
        puts "\nPlayer X Wins!\n"
        game_over
      elsif game_array.values_at(*combo) == %w(O O O)
        puts "\nPlayer O Wins!\n"
        game_over
      end
    end

    if game_array.any?(Integer) == false
      game_end = true
      build_board
      print"\nDraw!\n"
      game_over
    end


  end

end

game = GameManager.new

game.play
