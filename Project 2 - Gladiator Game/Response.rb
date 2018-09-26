# Different responses for different types of audience.
# These are the free and intelligent species of the world
# Most of them are good. Some of them are... weird.
class Response
  def initialize
    raise NotImplementedError
  end
  def win
    raise NotImplementedError
  end
  def lose
    raise NotImplementedError
  end
  def harm
    raise NotImplementedError
  end
end

class Human < Response
  def initialize

  end
  def win
    puts "Put on your happy pants!"
  end
  def lose
    puts "Until next time Commander..."
  end
  def harm
    puts "*gasp* You're bleeding!"
  end
end

class Asura < Response
  def initialize

  end
  def win
    puts "Your plan is just stupid and won’t work."
  end
  def lose
    puts "You’re dumb. You’ll die, and you’ll leave a dumb corpse."
  end
  def harm
    puts "You're hemorrhaging!"
  end
end

class Charr < Response
  def initialize

  end
  def win
    puts "Can't wait to tell my warband about this."
  end
  def lose
    puts "Too vulnerable like this!"
  end
  def harm
    puts "Gonna bleed out!"
  end
end

class Norn < Response
  def initialize

  end
  def win
    puts "By Bear! Another proud moment."
  end
  def lose
    puts "By Raven! The end is near."
  end
  def harm
    puts "By Wolf! The pain!"
  end
end

class Sylvari < Response
  def initialize

  end
  def win
    puts "I'll pass this along to the pale tree."
  end
  def lose
    puts "Another day older, another day wiser."
  end
  def harm
    puts "This rose has thorns and here they are!"
  end
end

class Skritt < Response
  def initialize

  end
  def win
    puts "More come, yes!"
  end
  def lose
    puts "That's right, you lose!"
  end
  def harm
    puts "You smell... (Sniff sniff) different!"
  end
end