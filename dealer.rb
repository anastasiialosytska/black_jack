# frozen_string_literal: true

class Dealer < User
  def deal_cards
    super
    2.times { puts '*' }
  end

  def add_card
    super
    puts 'Добавлена карта: *'
  end
end
