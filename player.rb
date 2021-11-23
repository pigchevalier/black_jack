class Player

  attr_accessor :bank, :name, :cards
  
  def initialize(name = "dealer")
    self.bank = 100
    self.name = name
    self.cards = []
  end

  def add_card(card)
    self.cards.push(card)
  end

  def points_total
    summ = 0
    cards.each do |card|
      if card.nominal == "V" || card.nominal == "D" || card.nominal == "K"
        summ += 10
      elsif card.nominal == "A"
        summ += 1
      else 
        summ += card.nominal.to_i
      end
    end
    cards.each {|card| summ += 10 if card.nominal == "A" && summ <= 11}    
    summ 
  end
end