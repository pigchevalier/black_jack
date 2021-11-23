require_relative 'card'
require_relative 'player'
require_relative 'user'
require_relative 'dealer'

class Game

  attr_reader :deck_of_cards

  attr_accessor :bank_of_game, :user, :dealer

  def initialize(user_name)
    create_deck
    self.user = User.new(user_name)
    self.dealer = Dealer.new
  end

  def refresh
    create_deck
    user.cards = []
    dealer.cards = []
  end

  def create_deck
    self.deck_of_cards = []
    nominals = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "V", "D", "K", "A"]
    suits = ["+", "<3", "^", "<>"]
    for suit in suits do
      for nominal in nominals do
        self.deck_of_cards.push(Card.new(nominal, suit))
      end
    end
  end

  def start_round 
    deal
    user.bank -= 10
    dealer.bank -= 10
    self.bank_of_game = 20
  end

  def deal
    issuing_a_card(user)
    issuing_a_card(user)
    issuing_a_card(dealer)
    issuing_a_card(dealer)
  end

  def move_dealer
    issuing_a_card(dealer) if dealer.move?
  end

  def user_add_card
    issuing_a_card(user) if user.cards.size < 3
  end

  def issuing_a_card(player)
    card = deck_of_cards.sample
    deck_of_cards.delete(card)
    player.add_card(card)
  end

  def end_game?
    true if user.cards.size == 3 && dealer.cards.size == 3
  end

  private

  attr_writer :deck_of_cards
end