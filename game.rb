# frozen_string_literal: true

class Game
  def initialize
    print 'Введите имя: '
    @name = gets.chomp
    @player = Player.new(@name)
    @dealer = Dealer.new
  end

  def start_game
    if bank_empty?
      puts 'В банке 0$. Конец игры.'
      exit
    end
    @player.first_deal
    @dealer.first_deal
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

  private

  def dealer_turn
    check_card_quantity
    check_score
    if @dealer.score < 17
      @dealer.add_card
    else
      puts '-----------------------'
      puts 'Пропускаю ход!'
    end
    player_turn
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
    puts '-----------------------'
    choice == 1 ? repeat_game : exit
  end

  def result
    case winner
    when 'draw'
      puts 'Ничья. Деньги из банка возвращаются игрокам'
      @player.bank += 10
      @dealer.bank += 10
    when 'player'
      @player.bank += User.general_bank
      puts "Вы выиграли, сумма очков: #{@player.score}, в банке #{@player.bank}$"
    when 'dealer'
      @dealer.bank += User.general_bank
      puts "Вы проиграли. В банке #{@player.bank}$"
    end
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

  def winner
    if @player.score <= 21 && @dealer.score <= 21
      winner = @player.score > @dealer.score ? 'player' : 'dealer'
    end
    winner = 'player' if @dealer.score > 21
    winner = 'dealer' if @player.score > 21
    winner = 'draw' if @player.score == @dealer.score
    winner
  end

  def bank_empty?
    @player.bank.zero? || @dealer.bank.zero? ? true : false
  end
end
