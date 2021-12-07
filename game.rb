class Game
  def initialize
    print "Введите имя: "
    @name = gets.chomp
    @player = Player.new(@name)
    @dealer = Dealer.new
  end

  def start_game    
    @player.deal_cards
    @dealer.deal_cards
    @player.place_bet
    @dealer.place_bet
  end

  def player_turn
    check_card_quantity
    check_score
    puts '-----------------------'
    puts 'Выберите действие:'
    puts '1. Пропустить ход'
    puts '2. Добавить карту'
    puts '3. Открыть карты'
    choice = gets.to_i
     case choice
     when 1
      dealer_turn
     when 2
      @player.add_card
      dealer_turn
     when 3
      end_game
    end
  end

  def dealer_turn
    check_card_quantity
    check_score
    if @dealer.score < 17
      @dealer.add_card
      player_turn
    else
      puts '-----------------------'
      puts 'Пропускаю ход!'
      player_turn
    end
  end

  def end_game
    puts '-----------------------'
    puts 'Игра окончена'
    @player.show_cards
    @dealer.show_cards
    result
    puts '-----------------------'
    puts 'Сыграть еще раз?'
    puts '1. Да'
    puts '2. Нет'
    choice = gets.to_i
    choice == 1 ? repeat_game : exit
  end

  def result
    if @player.score == @dealer.score
      puts 'Ничья. Деньги из банка возвращаются игрокам'
      @player.bank += 10
      @dealer.bank += 10
    elsif @player.score > 21
      puts "Вы проиграли, сумма очков: #{@player.score}"
      @dealer.bank += User.general_bank
    elsif @dealer.score > 21
      @player.bank += User.general_bank
      puts "Вы выиграли. В банке #{@player.bank}$"
    elsif @player.score <= 21 && @dealer.score <= 21
      if @player.score > @dealer.score
        @player.bank += User.general_bank
        puts "Вы выиграли. В банке #{@player.bank}$"
      else
        puts 'Вы проиграли'
        @dealer.bank += User.general_bank
      end
    end
    User.general_bank = 0
  end

  def check_card_quantity
    end_game if @player.cards.size >= 3 && @dealer.cards.size >= 3
  end

  def check_score
    end_game if @player.score >= 21 || @dealer.score >= 21
  end

  def repeat_game
    @player.cards.clear
    @dealer.cards.clear
    @player.score = 0
    @dealer.score = 0
    User.general_bank = 0
    start_game
    player_turn
  end
end
