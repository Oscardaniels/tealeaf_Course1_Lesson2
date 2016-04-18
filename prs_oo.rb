# Both players make a hand gesture of either "paper", "rock" or "scissors". 
# The outcome is declared by comparing whose hand gesture is dominant over the other.  
# It's a tie if both hands are the same  

class Hand
  include Comparable

  attr_reader :value
  def initialize(v)
    @value = v
  end

  def <=>(another_hand)
    if @value  == another_hand.value
      0
    elsif (@value == 'p' && another_hand.value == 'r') ||
          (@value == 'r' && another_hand.value == 's') ||
          (@value == 's' && another_hand.value == 'p')
      1
    else
      -1
    end
  end

  def display_winning_message
    case @value
    when 'p' 
      puts "Paper wraps Rock!"
    when 'r'
      puts "Rock smashes Scissors!"
    when 's'
      puts "Scissors cuts Paper!"
    end
  end
end

class Player

  attr_accessor :hand
  attr_reader :name

  def initialize(n)
    @name = n
  end

  def to_s
    "#{name} currently has #{self.hand.value}"
  end
end

class Human < Player
  def pick_hand
    begin
    puts "Pick one: (p, r, s)"
    c = gets.chomp.downcase  
    end until Game::CHOICES.keys.include?(c)
    self.hand = Hand.new(c)
  end
end

class Computer < Player
  def pick_hand
    self.hand = Hand.new(Game::CHOICES.keys.sample)
  end
end

class Game
  CHOICES = {'p' => 'Paper', 'r' => 'Rock', 's' => 'Scissors'}
  attr_accessor :human, :computer
  def initialize
    @human = Human.new("Bob")
    @computer = Computer.new("R2D2")
  end

  def compare_hands
    if human.hand == computer.hand
      puts "It's a tie"
    elsif human.hand > computer.hand
      puts "#{human.name} won!"
      human.hand.display_winning_message
    else
      puts "puts #{computer.name} won!"
      computer.hand.display_winning_message
    end
  end

  def play
    human.pick_hand
    computer.pick_hand
    compare_hands
    puts human
    puts computer
  end
end  

game = Game.new.play

