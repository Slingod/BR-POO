class Player
    attr_accessor :name, :life_points
  
    def initialize(name)
      @name = name
      @life_points = 10
    end
  
    def show_state
      puts "#{@name} a #{@life_points} points de vie"
    end
  
    def gets_damage(damage_received)
      @life_points -= damage_received
      if @life_points <= 0
        puts "le joueur #{@name} a été tué !"
      end
    end
  
    def attacks(player)
      puts "#{@name} attaque #{player.name}"
      damage = compute_damage
      player.gets_damage(damage)
      puts "il lui inflige #{damage} points de dommages"
    end
  
    def compute_damage
      return rand(1..6)
    end
  end
  
  class HumanPlayer < Player
    attr_accessor :weapon_level
  
    def initialize(name)
      super(name)
      @life_points = 10
      @weapon_level = 1
    end
  
    def show_state
      puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
    end
  
    def compute_damage
      return rand(2..10) * @weapon_level
    end
  
    def search_weapon
      new_weapon_level = rand(1..6)
      puts "Tu as trouvé une arme de niveau #{new_weapon_level}"
      if new_weapon_level > @weapon_level
        @weapon_level = new_weapon_level
        puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
      else
        puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
      end
    end
  
    def search_health_pack
      health_pack = rand(1..6)
      if health_pack == 1
        puts "Tu n'as rien trouvé..."
      elsif health_pack >= 2 && health_pack <= 5
        @life_points = [@life_points + 5, 10].min
        puts "Bravo, tu as trouvé un pack de +5 points de vie !"
      else
        @life_points = [@life_points + 8, 10].min
        puts "Waow, tu as trouvé un pack de +8 points de vie !"
      end
    end
  end  