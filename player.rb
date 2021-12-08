# frozen_string_literal: true

class Player < User
  attr_reader :name

  def initialize(name)
    super
    @name = name
  end

  def count_points
    super
    @cards.each_key { |key| puts key }
    puts "Сумма очков: #{score}"
  end

  def add_card
    super
    puts "Добавлена карта: #{@random_card}"
    puts "Сумма очков: #{@score}"
  end
end
