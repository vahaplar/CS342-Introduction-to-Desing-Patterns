require_relative 'Gladiator'

require_relative 'arenas/Arena.rb'
require_relative 'arenas/HeartOfThorns.rb'
require_relative 'arenas/PathOfFire.rb'

def main()

  puts "Welcome to the Guild Wars, gladiator!"
  puts "You are the commander of the Pact that protects the world."
  # User distributes character points
  begin
  puts "Tell your name to the world so everyone will hear it again: "
  name = gets.chomp
  puts "Tell me how fast you are: "
  speed = gets.to_i
  puts "Tell me your strength: "
  strength = gets.to_i
  puts "Tell me how smart you are: "
  intelligence = gets.to_i
  puts "Finally, how healthy you are: "
  health = gets.to_i
  # New character created
  g = Gladiator.new(name,speed,strength,intelligence,health)
  # Retries until user makes a valid distribution
  rescue ArgumentError
    puts "ERROR:"
    puts "Total number shouldn't exceed 20. Recreate your character:"
    puts
    retry
  end

  puts "You are ready for your adventure!"

  # Registering the audience to the character
  for i in 1..10
    audience = Audience.new(rand(6))
    g.register(audience)
  end
  puts "Many wanderers will come along with you and witness your greatness"

  # Character will be tested in two different arenas
  # Regardless of win/lose status, both arenas will be played
  puts "Let's start!"
  puts
  hot = HeartOfThorns.new(g)
  hot.init
  puts
  puts "Press any key to continue with the expansion pack."
  gets
  pof = PathOfFire.new(g)
  pof.init
  # Deregistering the audience of character
  for i in 1..10
    g.deregister(audience)
  end
  puts "The wanderers following you are leaving..."

end
main()