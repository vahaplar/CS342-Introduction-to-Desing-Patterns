# base Planet class
class Planet
  attr_reader :distance
  def initialize
    @distance = rand(0..300)
  end
end
# All planets have unique id values (seeded by object id)
# All planets have a bool variable for life (just in case...)
#
# Rocky Planet subclass with its own attributes
class RockyPlanet < Planet
  attr_accessor :id, :life
  def initialize
    super
    @id = "r#{object_id}"
    @life = false
  end
end
# Gaseous Planet subclass with its own attributes
class GaseousPlanet < Planet
  attr_accessor :id, :life
  def initialize
    super
    @id = "g#{object_id}"
    @life = false
  end
end
# Habitable Planet subclass with its own attributes
class HabitablePlanet < Planet
  attr_accessor :id, :life
  def initialize
    super
    @id = "h#{object_id}"
    @life = false
  end
end