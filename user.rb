class User
  attr_accessor :bank, :cards, :score

  DECK_OF_CARDS = { '2<3' => 2, '2+' => 2, '2<>' => 2, '2^' => 2, '3<3' => 3, '3+' => 3, '3<>' => 3, '3^' => 3, '4<3' => 4, '4+' => 4, '4<>' => 4, '4^' => 4,
                  '5<3' => 5, '5+' => 5, '5<>' => 5, '5^' => 5, '6<3' => 6, '6+' => 6, '6<>' => 6, '6^' => 6, '7<3' => 7, '7+' => 7, '7<>' => 7, '7^' => 7,
                  '8<3' => 8, '8+' => 8, '8<>' => 8, '8^' => 8, '9<3' => 9, '9+' => 9, '9<>' => 9, '9^' => 9, '10<3' => 10, '10+' => 10, '10<>' => 10, '10^' => 10,
                  'V<3' => 10, 'V+' => 10, 'V<>' => 10, 'V^' => 10, 'D<3' => 10, 'D+' => 10, 'D<>' => 10, 'D^' => 10, 'K<3' => 10, 'K+' => 10, 'K<>' => 10, 'K^' => 10,
                  'T<3' => 1, 'T+' => 1, 'T<>' => 1, 'T^' => 1 }

  @@general_bank = 0

  class << self
    def general_bank
      @@general_bank
    end

    def general_bank=(value)
      @@general_bank = value
    end
  end

  def initialize(*args)
    @bank = 100
    @cards = {}
    @score = 0
  end

  def deal_cards
    cards = DECK_OF_CARDS.keys
    2.times do |card|
      random_card = cards.sample
      @cards[random_card] = DECK_OF_CARDS[random_card]
    end
    @cards.each do |key, value|
      @score += value
      puts key
      end
    puts "Сумма очков #{self.class}: #{@score}"
  end

  def place_bet
    @bank -= 10
    @@general_bank += 10
    puts "Сумма в банке #{self.class}: #{@bank}$"
  end

  def add_card
    cards = DECK_OF_CARDS.keys
    random_card = cards.sample
    @cards[random_card] = DECK_OF_CARDS[random_card]
    @score += DECK_OF_CARDS[random_card]
    puts "Добавлена карта: #{random_card}"
    puts "Сумма очков: #{@score}"
  end

  def show_cards
    puts "Карты #{self.class}:"
    @cards.each_key { |key| puts key }
  end
end
