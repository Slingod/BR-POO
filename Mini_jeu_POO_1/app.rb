require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'


player1 = Player.new("Josiane")
player2 = Player.new("José")

puts "Voici l'état de chaque joueur :"
player1.show_state
player2.show_state

puts "Passons à la phase d'attaque :"

while player1.life_points > 0 && player2.life_points > 0
  player1.attacks(player2)
  if player2.life_points <= 0
    break
  end
  player2.attacks(player1)
  if player1.life_points <= 0
    break
  end
  puts "Voici l'état de chaque joueur :"
  player1.show_state
  player2.show_state
end

puts "Le combat est terminé."