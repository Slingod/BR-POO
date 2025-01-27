require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "------------------------------------------------"
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-------------------------------------------------"

puts "Quel est ton prénom ?"
user_name = gets.chomp
user = HumanPlayer.new(user_name)

enemies = [Player.new("Josiane"), Player.new("José")]

while user.life_points > 0 && (enemies.any? { |enemy| enemy.life_points > 0 })
  puts "\nVoici ton état :"
  user.show_state

  puts "Quelle action veux-tu effectuer ?"
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner"
  puts "0 - attaquer Josiane"
  puts "1 - attaquer José"

  choice = gets.chomp
  case choice
  when "a"
    user.search_weapon
  when "s"
    user.search_health_pack
  when "0"
    user.attacks(enemies[0])
  when "1"
    user.attacks(enemies[1])
  else
    puts "Choix invalide !"
  end

  enemies.each do |enemy|
    if enemy.life_points > 0
      enemy.attacks(user)
    end
  end

  enemies.reject! { |enemy| enemy.life_points <= 0 }
end

puts "La partie est finie"
if user.life_points > 0
  puts "BRAVO ! TU AS GAGNE !"
else
  puts "Loser ! Tu as perdu !"
end