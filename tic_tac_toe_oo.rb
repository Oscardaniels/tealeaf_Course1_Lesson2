# human and computer choose squares on a tic tac toe board with each trying
# to complete three in a row while trying to prevent the other from doing so first.

# a game has players[human, computer] and a board
# a game is played
# a game's rules determine if there is a winner
# a game asks if it would like to be repeated

# a board has squares and squares have values
# a board displays player squares

# players pick squares

# computer looks for winning combinations
# computer looks for blocking combinations
# computers choose to win, block, or move randomly
class Board   
  attr_accessor :square, :available_squares

  def initialize
    @square = {}
    (1..9).each {|num| self.square[num] = " "}
  end

  def draw
    system "cls" #For Windows users
    system 'clear' #For *nix users
    puts "  #{square[1]}  |  #{square[2]}  |  #{square[3]}  "
    puts "-----------------"
    puts "  #{square[4]}  |  #{square[5]}  |  #{square[6]}  "
    puts "-----------------"
    puts "  #{square[7]}  |  #{square[8]}  |  #{square[9]}"
  end

  def available_squares
    self.available_squares = square.select {|k, v| v == " "}

  end

  def full?
    !square.has_value?(" ")
  end
end

class Player
  attr_accessor :symbol, :board
end

class Human < Player
  def initialize(board)
    @symbol = "X"
    @board = board
    puts "Get ready to rumble!"
    sleep 1
  end

  def pick_square
    begin 
      puts 'please pick an open square (1-9)'
      choice = gets.chomp.to_i
    end until board.available_squares.has_key?(choice)
    board.square[choice] = "X"
    board.draw
  end
end

class Computer < Player
  def initialize(board)
    @symbol = "O"
    @board = board
  end

  def pick_square
    if winning_row = can_computer_win?
      computer_move(winning_row) 
    elsif blocking_row = can_computer_block?
      computer_move(blocking_row)      
    else
      available_squares = board.available_squares 
      choice = available_squares.keys.sample
      board.square[choice] = "O"
    end
    board.draw
  end

  def computer_move(target_squares)
    target_squares.each do |value| 
      if board.square[value] == " "
        board.square[value] = "O"
      end
    end
  end 

  def can_computer_win?
    Game::WINNING_ROWS.each do |winning_row|
      values = board.square.values_at(*winning_row)
      return winning_row if values.count("O") == 2 && values.count(" ") == 1
    end
    false
  end

  def can_computer_block?
    Game::WINNING_ROWS.each do |blocking_row|
      values = board.square.values_at(*blocking_row)
      return blocking_row if values.count("X") == 2 && values.count(" ") == 1
    end
    false
  end 
end


class Game
  WINNING_ROWS = [
                  [1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], 
                  [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]
                 ]
  attr_accessor :board, :human, :computer
  
  def initialize
    @board = Board.new
    @human = Human.new(board)
    @computer = Computer.new(board)
  end

  def play    
    board.draw
    begin
      human.pick_square
      break if winner?(human.symbol)
      computer.pick_square
      break if winner?(computer.symbol)
    end until board.full?
    display_final_message
  end

  def winner?(player_piece)
    #binding.pry
    game_over = false
    WINNING_ROWS.each do |winning_row|
      if winning_row.all? {|value| board.square[value] == player_piece}
        game_over = true
      end
    end
    game_over
  end

  def display_final_message
    if winner?(human.symbol)
      puts "You win!"
    elsif winner?(computer.symbol)
      puts "Tic-Tac_Terminator wins!" 
    else
      puts "It's a tie."
    end
  end

  def play_again?
    puts "Would you like to play again? (y/n)"
    return true if gets.chomp.downcase == 'y' 
  end
end

loop do
  game = Game.new
  game.play
  break unless game.play_again?
end

