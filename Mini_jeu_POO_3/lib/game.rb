class Game
    attr_accessor :human_player, :enemies, :players_left, :enemies_in_sight, :killed_enemies
  
    def initialize(human_name)
      @human_player = HumanPlayer.new(human_name)
      @players_left = 10
      @enemies_in_sight = []
      @killed_enemies = 0
      add_enemies
    end
  
    def add_enemies
      if @enemies_in_sight.size < @players_left
        @enemies_in_sight << Player.new("joueur_#{rand(1..10)}")
      end
    end
  
    def kill_player(player)
      @enemies_in_sight.delete(player)
      @killed_enemies += 1
    end
  
    def is_still_ongoing?
      @human_player.life_points > 0 && @killed_enemies < 10
    end
  
    def show_players
      puts "\nVoici ton état :"
      @human_player.show_state
      puts "Il reste #{@enemies_in_sight.size} ennemis en vue."
      puts "Tu as tué #{@killed_enemies} ennemis."
    end
  
    def menu
      puts "\nQuelle action veux-tu effectuer ?"
      puts "a - chercher une meilleure arme"
      puts "s - chercher à se soigner"
      @enemies_in_sight.each_with_index do |enemy, index|
        puts "#{index} - attaquer #{enemy.name}"
      end
    end
  
    def menu_choice(choice)
      case choice
      when "a"
        @human_player.search_weapon
      when "s"
        @human_player.search_health_pack
      when /\d+/
        index = choice.to_i
        if index < @enemies_in_sight.size
          @human_player.attacks(@enemies_in_sight[index])
          kill_player(@enemies_in_sight[index]) if @enemies_in_sight[index].life_points <= 0
        else
          puts "Choix invalide !"
        end
      else
        puts "Choix invalide !"
      end
    end
  
    def enemies_attack
      @enemies_in_sight.each do |enemy|
        if enemy.life_points > 0
          if rand(1..2) == 1
            enemy.attacks(@human_player)
          else
            other_enemies = @enemies_in_sight.reject { |e| e == enemy }
            if other_enemies.any?
              target = other_enemies.sample
              enemy.attacks(target)
              kill_player(target) if target.life_points <= 0
            end
          end
        end
      end
    end
  
    def end
      puts "La partie est finie"
      if @human_player.life_points > 0
        puts "BRAVO ! TU AS GAGNÉ !"
      else
        puts "Loser ! Tu as perdu !"
      end
    end
  end  