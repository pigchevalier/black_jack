class Card
  attr_reader :nominal, :suit
  
  NOMINALS = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "V", "D", "K", "A"]
  SUITS = ["+", "<3", "^", "<>"]

  def initialize(nominal, suit)
    @nominal = nominal
    @suit = suit
  end
end