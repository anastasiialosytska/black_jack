# frozen_string_literal: true

require_relative 'user'
require_relative 'player'
require_relative 'dealer'
require_relative 'game'

game = Game.new
game.start_game
game.player_turn
