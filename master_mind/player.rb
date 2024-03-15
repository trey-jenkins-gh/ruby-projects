require_relative 'utils.rb'


class Player

  attr_reader :role, :name

  def initialize (args = {})
    @role = args[:role]
    @name = args[:name]
    @inputs = InputManager.new()
    role_desc
  end

  def greeting
    puts "\n#{@name}, you are the #{@role}."
  end

end


class Maker < Player
  require 'io/console'
  attr_writer :name

  def initialize(args = {})
    @name = args[:name] || "CPU"
    @role = "Code Maker"
  end

  def role_desc
    print "#{greeting} Your job is to set a hard to guess password that the Code Breaker can't crack!\n"
  end
end

class Breaker < Player
  attr_writer :name

  def initialize(args = {})
    @role = "Code Breaker"
    @name = args[:name]
  end

  def role_desc
    print "#{greeting} Your job is to guess the Password before you run out of turns!\n"
  end
end


class CPU < Player
  def initialize
    @role = "CPU"
    @name = "CPU"
    role_desc
  end

  def role_desc
    "The CPU is your opponent. Good Luck!"
  end

  def make_input
    input = ['1', '1', '1', '1']
  end

  def cpu_player
    guess = []
    guess.push(cpu_gen_input(4))
    cpu_check_input(guess) == true ? guess : cpu_player
  end
end
