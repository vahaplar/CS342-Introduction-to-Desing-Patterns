require 'timeout'
require_relative 'Arena'
# Arena subclass
class HeartOfThorns < Arena
  # Initializing with the gladiator
  def initialize(gladiator)
    @gladiator = gladiator
    # Retry chances of user
    @retries = 2
    puts "Welcome to Heart Of Thorns, #{@gladiator.name}!"
    puts "Here in Maguuma Jungle, you are tasked to defeat"
    puts "the Elder Dragon of plant and mind: Mordremoth!"
    puts "First you will race to reach on top of the jungle"
    puts "Then the power of your mind will be tested against him"
    puts "Finally, you will face his wrath in physical form at his domain"
    puts "When you are ready, enter any key to continue..."
    gets
  end
  # Speed test
  def race
    puts "To reach Mordremoth's domain, you have to escape his minions."
    puts "While ascending the Blighting Tree, you have to act fast."
    puts "Use 'L' and 'R' keys at the right moment to dodge enemy attacks."
    puts "When you are ready, enter any key to continue..."
    gets

    time_limit = 0
    speed = @gladiator.speed*5
    # Users time limit changes according to character speed
    if speed < 10
      time_limit = 2
    elsif speed < 20
      time_limit = 4
    elsif speed < 30
      time_limit = 6
    elsif speed < 40
      time_limit = 8
    elsif speed < 50
      time_limit = 10
    else
      time_limit = 15
    end
    # Using timeout() game will block user input after time limit
    begin Timeout.timeout(time_limit) do

      dodge = rand(2)
      # Notify audience according to win/lose
      if dodge == 0
        puts "Enemy attacking from left. Dodge to RIGHT!"
        input = gets.chomp

        if input == 'R' || input == 'r'
          puts "Mordremoth's mindless minions can't compete with you!"
          @gladiator.notify("win")
          puts
        else
          puts "A minion hit you with a whip attack and you fell..."
          @gladiator.notify("lose")
          puts
        end
      else
        puts "Enemy attacking from right. Dodge to LEFT!"
        input = gets.chomp

        if input == 'L' || input == 'l'
          puts "Mordremoth's mindless minions can't compete with you!"
          @gladiator.notify("win")
          puts
        else
          puts "A minion hit you with a whip attack and you fell..."
          @gladiator.notify("lose")
          puts
        end
      end
    end
    # Rescue the error and notify audience if time limit is exceeded
    rescue Timeout::Error
      puts "A minion hit you with a whip attack and you fell..."
      @gladiator.notify("lose")
    end
  end

  # Intelligence test
  def puzzle
    puts "Mordremoth has tricked you and prisoned you in his mind."
    puts "You have to answer all his riddles to get out."
    puts "If you are ready, enter any key to continue..."
    gets

    int = @gladiator.intelligence*5
    puts "Commander, your intelligence level is #{int}/100"
    # According to intelligence level, riddles get harder.
    if int < 5
      puts "Mordremoth: And you dared to defy my eternal will? BEGONE!"
      @gladiator.notify("lose")
      puts
    elsif int < 15
      puts "Mordremoth: Here's a riddle for you:"
      puts "I come for all who grow, crawl, and walk. I am the perfect hunter."
      puts "In the end, I am the victor. What is my name?"
      puts "Is it 'LEGEND' or 'DEATH' or 'FUTURE'?"
      puts "Your answer is:"
      answer = gets.chomp

      if answer == "DEATH"
        puts "Mordremoth: Good one! I love a tough challenger."
        @gladiator.notify("win")
        puts
      else
        puts "Mordremoth: And you dared to defy my eternal will? BEGONE!"
        @gladiator.notify("lose")
        puts
      end
    elsif int < 25
      puts "Mordremoth: Here's a riddle for you:"
      puts "'FIRE' and 'WATER' came to your aid, one will harm, other feed."
      puts "What will harm me?"
      puts "Your answer is:"
      answer = gets.chomp

      if answer == "FIRE"
        puts "Mordremoth: Good one! I love a tough challenger."
        @gladiator.notify("win")
        puts
      else
        puts "Mordremoth: And you dared to defy my eternal will? BEGONE!"
        @gladiator.notify("lose")
        puts
      end
    elsif int < 50
      puts "Mordremoth: Here's a riddle for you:"
      puts "What is my name?"
      puts "Your answer is:"
      answer = gets.chomp

      if answer == "MORDREMOTH" || answer == "mordremoth" ||
          answer == "Mordremoth"
        puts "Mordremoth: Good one! I love a tough challenger."
        @gladiator.notify("win")
        puts
      else
        puts "Mordremoth: Pathetic... BEGONE!"
        @gladiator.notify("lose")
        puts
      end
    else
      puts "Mordremoth: Your will is too strong! I can't hold it much longer"
      puts "The Elder Dragon escapes..."
      @gladiator.notify("win")
      puts
    end
  end
  # Strength and Health test
  def battle

    puts "You have reached the dragon's domain! You will fight him here."
    puts "Mordremoth's biggest weakness if that he is made of plants."
    # User character's base values
    gladiator_str = @gladiator.strength+10
    gladiator_heal = @gladiator.health*10

    puts "Commander, your initial strength is #{gladiator_str}"
    puts "Commander, your initial health is #{gladiator_heal}"
    puts "Enchant your weapon with the sigil of your choice:"

    puts "1) Sigil of Water"
    puts "2) Sigil of Earth"
    puts "3) Sigil of Fire"
    puts "4) Sigil of Air"
    puts "5) No Sigil"
    # Enemy base values
    enemy_str = 5
    enemy_heal = 150
    # Character may get a buff/nerf according to his choice
    sigil = gets.to_i

    if sigil == 1
      puts "Sigil Of Water, very bad choice against a plant enemy..."
      gladiator_str -= 10
      puts "Your strength has decreased to #{gladiator_str}"
    elsif sigil == 2
      puts "Sigil Of Earth, not a good choice against a plant enemy..."
      gladiator_str -= 5
      puts "Your strength has decreased to #{gladiator_str}"
    elsif sigil == 3
      puts "Sigil Of Fire, very good choice against a plant enemy..."
      gladiator_str += 10
      puts "Your strength has increased to #{gladiator_str}"
    elsif sigil == 4
      puts "Sigil Of Air, kind of good choice against a plant enemy..."
      gladiator_str += 5
      puts "Your strength has increased to #{gladiator_str}"
    else
      puts "You decided to use no sigil on your weapon."
    end

    puts "When you are ready, enter any key to continue..."
    gets

    puts "The battle has begun!"
    # Battle continues while enemy and gladiator are alive
    while enemy_heal > 0 && gladiator_heal > 0

      puts "You attack Mordremoth successfully"
      enemy_heal -= gladiator_str
      puts "Mordremoth's health is #{enemy_heal}"
      # Enemy always strikes last
      if enemy_heal> 0
        puts "Mordremoth strikes at you"
        gladiator_heal -= enemy_str
        puts "Your health is #{gladiator_heal}"
        @gladiator.notify("harm")
        puts
      end
    end
    # Outcome of final battle is designated here.
    # User has several retry changes before losing completely.
    if enemy_heal <= 0
      @gladiator.notify("win")
      puts
      puts "You have defeated Mordremoth! Now the world is safe."
      puts "Or is it? Find out in the next episode: Path Of Fire!"

    elsif @retries > 0
      @gladiator.notify("lose")
      puts "Mordremoth has beaten you... You'll return again."
      @retries -= 1
      battle
    else
      @gladiator.notify("lose")
      puts "You are dead... Game Over!"
    end
  end
end