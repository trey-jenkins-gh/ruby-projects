class BoardManager
  attr_accessor :state

  def initialize(state = 0)
    @state = state
  end


  STICKMAN = {
    0 => [
      ["             HANGMAN          "],
      ["----------------------|       "],
      ["|                     |       "],
      ["|                     |       "],
      ["|                             "],
      ["|                             "],
      ["|                             "],
      ["|                             "],
      ["|                             "],
      ["|                             "],
      ["------------------------------"]],
    1 => [
      ["             HANGMAN          "],
      ["----------------------|       "],
      ["|                     |       "],
      ["|                     |       "],
      ["|                     O       "],
      ["|                             "],
      ["|                             "],
      ["|                             "],
      ["|                             "],
      ["|                             "],
      ["------------------------------"]],
    2 => [
      ["             HANGMAN          "],
      ["----------------------|       "],
      ["|                     |       "],
      ["|                     |       "],
      ["|                     O       "],
      ["|                     |       "],
      ["|                     |       "],
      ["|                             "],
      ["|                             "],
      ["|                             "],
      ["------------------------------"]],
    3 => [
      ["             HANGMAN          "],
      ["----------------------|       "],
      ["|                     |       "],
      ["|                     |       "],
      ["|                     O       "],
      ["|                     |\\      "],
      ["|                     |       "],
      ["|                             "],
      ["|                             "],
      ["|                             "],
      ["------------------------------"]],
    4 => [
      ["             HANGMAN          "],
      ["---------------------|        "],
      ["|                    |        "],
      ["|                    |        "],
      ["|                    O        "],
      ["|                   /|\\       "],
      ["|                    |        "],
      ["|                             "],
      ["|                             "],
      ["|                             "],
      ["------------------------------"]],
    5 => [
      ["             HANGMAN          "],
      ["---------------------|        "],
      ["|                    |        "],
      ["|                    |        "],
      ["|                    O        "],
      ["|                   /|\\       "],
      ["|                    |        "],
      ["|                     \\       "],
      ["|                             "],
      ["|                             "],
      ["------------------------------"]],
    6 => [
      ["             HUNGMAN          "],
      ["----------------------|       "],
      ["|                     |       "],
      ["|                     |       "],
      ["|                     O       "],
      ["|                    /|\\      "],
      ["|                     |       "],
      ["|                    / \\      "],
      ["|                             "],
      ["|         GAME OVER           "],
      ["------------------------------"]],
  }

  def test_board
    (0..6).each do |state|
      print_board(state)
    end
  end

  def print_board(state)
    system('clear')
    puts STICKMAN[state]
  end
end

# test_board = BoardManager.new()
# test_board.test_board