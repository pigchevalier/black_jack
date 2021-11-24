require_relative 'game'

class Interface

  attr_accessor :game, :user_name

  def initialize 
    puts "Введите ваше имя"
    self.user_name = gets.chomp
    self.game = Game.new(user_name)
    start_game
  end

  private

  def start_game
    game.refresh
    game.start_round
    puts "Банк игры = #{game.bank_of_game}"
    puts "Банк #{game.user.name} = #{game.user.bank}"
    puts "Банк #{game.dealer.name} = #{game.dealer.bank}"

    while true do
      show_hands
      puts "#{game.user.name} ваш ход"
      puts "Введите номер варианта"

      puts "1 Пропустить"
      puts "2 Открыть карты"
      puts "3 Добавить карту" if game.user.cards.size < 3

      var = gets.chomp.to_i

      case var
      when 1
        game.move_dealer
      when 2
        break
      when 3
        if game.user.cards.size == 3
          puts "Вы не можете добавить карту, когда у вас их 3"
          next
        else
          game.user_add_card
          game.move_dealer
        end
      else
        puts "Такого варианта нет"
        next
      end
      break if game.end_game?
    end
    end_of_round
    if win? 
      puts "Всего доброго"
    else
      puts "Хотите сыграть ещё раз? (1-да, 2-нет)"
      opt = gets.chomp.to_i
      if opt == 1
        start_game
      else 
        puts "Всего доброго"
      end
    end
  end

  def show_hands(end_of_game = nil)
    puts "#{game.user.name}"
    game.user.cards.each{ |card| puts "#{card.nominal}#{card.suit}"}
    puts "Сумма = #{game.user.points_total}"
    if !end_of_game      
      puts "#{game.dealer.name}"
      game.dealer.cards.each{ |card| puts "*"}
    else
      puts "#{game.dealer.name}"
      game.dealer.cards.each{ |card| puts "#{card.nominal}#{card.suit}"}
      puts "Сумма = #{game.dealer.points_total}"
    end
  end

  def end_of_round
    show_hands(true)
    if game.user.points_total > 21 && game.dealer.points_total > 21
      game.user.bank += game.bank_of_game/2
      game.dealer.bank += game.bank_of_game/2
    elsif game.user.points_total > 21
      game.dealer.bank += game.bank_of_game
    elsif game.dealer.points_total > 21
      game.user.bank += game.bank_of_game
    elsif game.user.points_total < game.dealer.points_total
      game.dealer.bank += game.bank_of_game
    elsif game.user.points_total == game.dealer.points_total
      game.user.bank += game.bank_of_game/2
      game.dealer.bank += game.bank_of_game/2
    else
      game.user.bank += game.bank_of_game
    end
    game.bank_of_game = 0
    puts "Банк #{game.user.name} = #{game.user.bank}"
    puts "Банк #{game.dealer.name} = #{game.dealer.bank}"
  end

  def win?
    if game.user.bank == 0
      puts "Вы проиграли"
      true
    elsif game.dealer.bank ==0
      puts "Вы выиграли"
      true
    end
  end

end