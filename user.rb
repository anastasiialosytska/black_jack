# frozen_string_literal: true

class User
  attr_accessor :bank, :cards, :score, :random_card

  DECK_OF_CARDS = { '2<3' => 2, '2+' => 2, '2<>' => 2, '2^' => 2, '3<3' => 3, '3+' => 3,
                    '3<>' => 3, '3^' => 3, '4<3' => 4, '4+' => 4, '4<>' => 4, '4^' => 4,
                    '5<3' => 5, '5+' => 5, '5<>' => 5, '5^' => 5, '6<3' => 6, '6+' => 6,
                    '6<>' => 6, '6^' => 6, '7<3' => 7, '7+' => 7, '7<>' => 7, '7^' => 7,
                    '8<3' => 8, '8+' => 8, '8<>' => 8, '8^' => 8, '9<3' => 9, '9+' => 9,
                    '9<>' => 9, '9^' => 9, '10<3' => 10, '10+' => 10, '10<>' => 10, '10^' => 10,
                    'V<3' => 10, 'V+' => 10, 'V<>' => 10, 'V^' => 10, 'D<3' => 10, 'D+' => 10,
                    'D<>' => 10, 'D^' => 10, 'K<3' => 10, 'K+' => 10, 'K<>' => 10, 'K^' => 10,
                    'T<3' => 1, 'T+' => 1, 'T<>' => 1, 'T^' => 1 }.freeze

  @@general_bank = 0
  @@cards = DECK_OF_CARDS.keys

  class << self
    def general_bank
      @@general_bank
    end

    def general_bank=(value)
      @@general_bank = value
    end
  end

  def initialize(*_args)
    @bank = 100
    @cards = {}
    @score = 0
  end

  def first_deal
    deal_cards
    count_points
  end

  def place_bet
    @bank -= 10
    @@general_bank += 10
  end

  def add_card
    @random_card = @@cards.sample
    @cards[random_card] = DECK_OF_CARDS[random_card]
    @score += DECK_OF_CARDS[random_card]
  end

  def show_cards
    puts "Карты #{self.class}:"
    @cards.each_key { |key| puts key }
  end

  protected

  def deal_cards
    2.times do |_card|
      @random_card = @@cards.sample
      @cards[random_card] = DECK_OF_CARDS[random_card]
    end
  end

  def count_points
    @cards.each do |key, value|
      value += 10 if key.start_with?('T') && @score <= 11
      @score += value
    end
  end
end
