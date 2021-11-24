require_relative 'card'

class DeckOfCards
  
  attr_accessor :deck_of_cards

  def initialize
    self.deck_of_cards = []
    for suit in Card::SUITS do
      for nominal in Card::NOMINALS do
        self.deck_of_cards.push(Card.new(nominal, suit))
      end
    end
  end

  def sample
    deck_of_cards.sample
  end

  def delete(card)
    deck_of_cards.delete(card)
  end
end