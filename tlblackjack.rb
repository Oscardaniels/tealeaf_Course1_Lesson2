class Card
  attr_accessor :suit, :face_value

  def initialize(s, fv)
    @suit = s
    @face_value = fv
  end

  def pretty_output
    "The #{face_value} of #{find_suit}"
  end

  def to_s
    pretty_output
  end

  def find_suit
    ret_val = case suit
                when 'H' then 'Hearts'
                when 'D' then 'Diamonds'
                when 'S' then 'Spades'
                when 'C' then 'Clubs'
              end
    ret_val
  end
end

class Deck
  attr_accessor :cards
  def initialize
    @cards = []
    ['H', 'D', 'S', 'C'].each do |suit|
      ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']. each do |face_value|
        @cards << Card.new(suit, face_value)
      end
    end
    scramble
  end

  def scramble
    cards.shuffle!
  end
  
  def deal_one
    cards.pop
  end

  def size
    cards.size
  end
end

module Hand
  def show_hand
    puts "---- #{name}'s Hand ----"
    cards.each do |card|
      puts "=> #{card}"
    end
    puts "=> Total: #{total}"
    puts
  end

  def total
    face_values = cards.map{|card| card.face_value}

    total = 0
    face_values.each do |val|
      if val == "A"
        total += 11
      else
        total += (val.to_i == 0 ? 10 : val.to_i)
      end
    end
    face_values.select{|val| val == "A"}.count.times do 
      break if total <= Game::BLACKJACK_AMOUNT
      total -= 10
    end
    total
  end

  def add_card(new_card)
    cards << new_card
  end

  def busted?
    total > Game::BLACKJACK_AMOUNT
  end

  def blackjack?
    total == Game::BLACKJACK_AMOUNT
  end

  def hit_or_stay
    choice = ""
    loop do
      puts "Would you like to hit or stay? (h/s)"
      choice = gets.chomp.downcase
      break if ['h','s'].include?(choice)
    end
    choice
  end
end

class Player
  include Hand

  attr_accessor :name, :cards

  def initialize(n)
    @name = n
    @cards = []
  end

  def take_turn(deck)
    return if blackjack?
    loop do
      if hit_or_stay == 'h'
        puts "You've chosen to hit."
        sleep 1
        add_card(deck.deal_one)
        puts "Your card: #{cards.last}"
        sleep 1
        show_hand
      else 
        puts "You've chosen to stay."
        sleep 1
        break
      end
      break if busted? || blackjack?
    end
  end
end

class Dealer
  include Hand
  attr_accessor :name, :cards, :hide_hole_card

  def initialize
    @name = "Dealer"
    @cards = []
    @hide_hole_card = true
  end

  def show_hand
    if hide_hole_card == true
      puts "---- #{name}'s Hand ----"
      puts "=> The ?? of ?????"
      puts "=> #{cards.last}"
      puts '=> Total: ??'
      self.hide_hole_card = false
    else
      puts "---- #{name}'s Hand ----"
      cards.each do |card|
        puts "=> #{card}"
      end
      puts "=> Total: #{total}" 
    end
  end

  def take_turn(deck)
    puts "Dealer's hole card is #{cards.first}"
    sleep 1
    show_hand
    sleep 2
    loop do
      if total < Game::DEALER_HIT_AMOUNT
        puts "Dealer hits."
        sleep 1
        add_card(deck.deal_one)
        puts "Dealer's card: #{cards.last}"
        sleep 1
        show_hand
        sleep 2
      else 
        puts "Dealer stays."
        sleep 1
        break
      end
      break if busted? || blackjack?
    end
  end
end

class Game
  attr_accessor :deck
  attr_reader :player, :dealer

  BLACKJACK_AMOUNT = 21
  DEALER_HIT_AMOUNT = 17
  
  def initialize(n)
    @deck = Deck.new
    @player = Player.new(n)
    @dealer = Dealer.new
  end

  def initial_deal
    player.add_card(deck.deal_one)
    dealer.add_card(deck.deal_one)
    player.add_card(deck.deal_one)
    dealer.add_card(deck.deal_one)
  end

  def play
    system "cls"
    initial_deal
    player.show_hand
    dealer.show_hand
    player.take_turn(deck)
    if !player.busted? && !player.blackjack?
      dealer.take_turn(deck)
    end
    results
  end

  def self.display_totals
    sleep 1
    puts "#{player.name}: #{player.total} Dealer: #{dealer.total}"
  end

  def results
    case 
    when player.busted? then puts "You busted. Dealer wins."
    when dealer.busted? then puts "Dealer busted! You win."
    when player.total > dealer.total then puts "#{player.name} wins."
    when dealer.total > player.total then puts "Dealer wins."
    when dealer.total == player.total then puts "It's a push."
    end
  end

  def play_again
    puts "Would you like to play again? (y/n)"
    gets.chomp.downcase
  end
end

def get_name
  puts "What is your name?"
  name = gets.chomp.capitalize
end

name = get_name
loop do
  game = Game.new(name)
  game.play
  break unless game.play_again == 'y'
end


