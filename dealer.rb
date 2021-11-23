require_relative 'player'

class Dealer < Player

  def move?
    true if points_total < 17 && cards.size < 3
  end

end