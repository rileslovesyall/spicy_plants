require './lib/spicy_plants'
require 'pry'

puts "Well howdy there."
puts "Welcome to Spicy Plants, the coolest game for growing plants that you have Ever Played."
puts ""

game = SpicyPlants::Game.new()
game.play