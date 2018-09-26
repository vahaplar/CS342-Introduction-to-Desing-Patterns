require 'timeout'
require_relative 'Arena'
# Arena subclass
class PathOfFire < Arena
  # Initializing with the gladiator
  def initialize(gladiator)
    @gladiator = gladiator
    # Important story items
    @artifact_key = 0
    @artifact_rune = 0
    # Retry chances of user
    @retries = 2

    puts "Welcome to Path Of Fire, #{@gladiator.name}!"
    puts "Mordremoth's death was just the beginning of downfall of the world"
    puts "The magic energy that Mordremoth possessed has spread everywhere."
    puts "There are many who wants to rule the world with this energy"
    puts "You are the only one to stop them!"
    puts
    puts "Here in Crystal Desert, you will defeat one of these enemies"
    puts "The rogue God of War and Fire: Balthazar!"
    puts "Balthazar wants to steal artifacts of other gods to possess power."
    puts "You must get the Library Key of Kormir, the God of Order and Truth"
    puts "Then, you will capture the Rune of Dwayna, the God of Air and Life"
    puts "Finally Balthazar himself will show up to stop you!"
    puts "When you are ready, enter any key to continue..."
    gets
  end
  # Test of speed
  def race
    puts "Kormir's Library keeps all the information needed to capture magic."
    puts "You need to find the key before Balthazar finds it!"
    puts "It's locked behind 3 gates in Kormir's Palace"
    puts "Order of Whispers will provide you the keywords to the right gates"
    puts "You must enter them right and as quickly as possible!"
    puts "You approach to the first gate, enter any key to continue..."
    gets
    # Score system keeps track of progress
    gladiator_score = 0
    balthazar_score = 0
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
      puts "Our intel shows first gate opens with the keyword 'TRUTH'"
      input = gets.chomp
      if input == 'TRUTH'
        puts "You were faster than Balthazar"
        gladiator_score += 1
      else
        puts "Wrong keyword! Balthazar is faster than you"
        balthazar_score += 1
      end
    end
    # Rescue the error and notify audience if time limit is exceeded
    rescue Timeout::Error
      puts "Too slow... Balthazar is faster than you"
      balthazar_score += 1
    end

    puts "You approach to the next gate, enter any key to continue..."
    gets

    begin Timeout.timeout(time_limit) do
      puts "Our intel shows second gate opens with the keyword 'SPIRIT'"
      input = gets.chomp

      if input == 'SPIRIT'
        puts "You were faster than Balthazar"
        gladiator_score += 1
      else
        puts "Wrong keyword! Balthazar is faster than you"
        balthazar_score += 1
      end
    end
    rescue Timeout::Error
      puts "Too slow... Balthazar is faster than you"
      balthazar_score += 1
    end

    puts "You approach to the last gate, enter any key to continue..."
    gets

    begin Timeout.timeout(time_limit) do
      puts "Our intel shows third gate opens with the keyword 'ORDER'"
      input = gets.chomp

      if input == 'ORDER
'
        puts "You were faster than Balthazar"
        gladiator_score += 1
      else
        puts "Wrong keyword! Balthazar is faster than you"
        balthazar_score += 1
      end
    end
    rescue Timeout::Error
      puts "Too slow... Balthazar is faster than you"
      balthazar_score += 1
    end
    # Notify audience according to score comparison
    if(gladiator_score > balthazar_score)
      puts "You proved your agility against Balthazar and captured the Key"
      @artifact_key += 1
      @gladiator.notify("win")
    else
      puts "Balthazar has bested you..."
      @gladiator.notify("lose")
    end
  end
  # Intelligence test
  def puzzle

    int = @gladiator.intelligence*5
    # Your failures might strengthen the enemy
    if @artifact_key == 0
      puts
      puts "Balthazar is not the smartest guy in the world"
      puts "But he is smarter with the Library Key of Kormir"
      int -= 5
    end
    puts
    puts "Rune of Dwayna has regenerative powers which might be dangerous"
    puts "in the hands of a God of War. You shouldn't let him have it."
    puts "If you are ready, enter any key to continue..."
    gets

    puts "Commander, your intelligence level is #{int}/100"
    # According to intelligence level, riddles get harder.
    if int < 5
      puts "Balthazar: Pathetic! And intelligence isn't even my speciality!"
      @gladiator.notify("lose")
      puts
    elsif int < 15
      puts "Balthazar: Here's a riddle for you:"
      puts "I feast on air, but drink no water. I have no eyes of my own"
      puts "but without me, you are blind. What am I?"
      puts "Is it 'TREE' or 'BIRD' or 'FIRE'?"
      puts "Your answer is:"
      answer = gets.chomp

      if answer == "FIRE"
        puts "Balthazar: Good one! I love a tough challenger."
        @gladiator.notify("win")
        @artifact_rune += 1
        puts
      else
        puts "Balthazar: I will rule this world!"
        @gladiator.notify("lose")
        puts
      end
    elsif int < 25
      puts "Balthazar: Here's a riddle for you:"
      puts "'FIRE' and 'WATER' came to your aid, one will harm me one will feed."
      puts "What will harm me?"
      puts "Your answer is:"
      answer = gets.chomp

      if answer == "WATER"
        puts "Balthazar: Good one! I love a tough challenger."
        @gladiator.notify("win")
        @artifact_rune += 1
        puts
      else
        puts "Balthazar: You are a fool!"
        @gladiator.notify("lose")
        puts
      end
    elsif int < 50
      puts "Balthazar: Here's a riddle for you:"
      puts "What is my name?"
      puts "Your answer is:"
      answer = gets.chomp

      if answer == "BALTHAZAR" || answer == "balthazar"  ||
          answer == "Balthazar"
        puts "Balthazar: Well... You know me."
        @gladiator.notify("win")
        @artifact_rune += 1
        puts
      else
        puts "Balthazar: You... Shall... BURN!"
        @gladiator.notify("lose")
        puts
      end
    else
      puts "Balthazar: I can't compete with you."
      puts "The god runs away..."
      @gladiator.notify("win")
      @artifact_rune += 1
      puts
    end
  end
  # Strength and Health test
  def battle
    # Your failures might strengthen the enemy
    rune_charges = 0
    if @artifact_rune == 0
      puts "Rune of Dwayna provides Balthazar regeneration"
      puts "When he is about to die, he will use this artifact"
      puts
      rune_charges = 3
    end

    puts "Don't be afraid of fighting a God, #{@gladiator.name}"
    puts "As just a mere mortal, you brought him upon your feet!"
    puts "And after all you can gaze into his eyes without any trouble"
    puts "Still be careful and choose your weapon wisely."
    puts "Don't forget, he draws his powers from Fire."
    puts "When you are ready, enter any key to continue..."
    gets
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
      puts "Sigil Of Water, very good choice against the God of Fire..."
      gladiator_str += 10
      puts "Your strength has decreased to #{gladiator_str}"
    elsif sigil == 2
      puts "Sigil Of Earth, kind of a good choice against the God of Fire..."
      gladiator_str += 5
      puts "Your strength has decreased to #{gladiator_str}"
    elsif sigil == 3
      puts "Sigil Of Fire, very bad choice against the God of Fire..."
      gladiator_str -= 10
      puts "Your strength has increased to #{gladiator_str}"
    elsif sigil == 4
      puts "Sigil Of Air, not a good choice against the God of Fire..."
      gladiator_str -= 5
      puts "Your strength has increased to #{gladiator_str}"
    else
      puts "You decided to use no sigil on your weapon."
    end

    puts "When you are ready, enter any key to continue..."
    gets

    puts "The battle has begun!"
    # Battle continues while enemy and gladiator are alive
    while enemy_heal > 0 && gladiator_heal > 0

      puts "You attack Balthazar successfully"
      enemy_heal -= gladiator_str
      puts "Balthazar's health is #{enemy_heal}"
      # In enemy possesses a special item, he can heal back several times.
      if enemy_heal <= 0 && rune_charges > 0
      puts "Balthazar uses Rune of Dwayna to heal the killing blow"
      enemy_heal += gladiator_str
      rune_charges -= 1
      end
      # Enemy always strikes last
      if enemy_heal > 0
        puts "Balthazar strikes at you"
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
      puts "You have defeated Balthazar! Now the world is safe."
      puts "Or is it?"
      puts "..."

    elsif @retries > 0
      @gladiator.notify("lose")
      puts "Balthazar has beaten you... You'll return again."
      @retries -= 1
      battle
    else
      @gladiator.notify("lose")
      puts "You are dead... Game Over!"
    end
  end
end