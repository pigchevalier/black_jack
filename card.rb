class Card
  attr_reader :nominal, :suit
  def initialize(nominal, suit)
    @nominal = nominal
    @suit = suit
  end
end