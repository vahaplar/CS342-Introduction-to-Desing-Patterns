require_relative "Room"
require_relative "Ant"

class ForagerRoom < Room
  def newAnt(type, hill)
    ant = Ant.new()
    ant.type = type
    ant.hill_name = hill
    return ant
  end
end