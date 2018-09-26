require_relative 'Planet'
# base class for Star
class Star
  attr_accessor :x, :y, :z, :planets
  # initializing star with base attributes, its location.
  def initialize
    @x = rand(2**3..2**64) - 1
    @y = rand(2**3..2**64) - 1
    @z = rand(2**3..2**64) - 1
  end
  def moreAttributes
    raise NoMethodError
  end
  # planet generation. each star has its own variables for planets
  def planetGeneration(range_of_planets, chances_of_life,
                       goldilocks_min, goldilocks_max)
    # list of planets generated
    @planets = []
    # planets types are designated randomly. habitable planes may have life
    # there has to be a set of conditions and a factor of luck for life
    (1..range_of_planets).each do
      type = rand(3)
      p = nil
      p = if type == 0
            RockyPlanet.new
          elsif type == 1
            GaseousPlanet.new
          else
            HabitablePlanet.new
          end
      if  (p.is_a? HabitablePlanet) &&
          rand(10_000) < chances_of_life*10_000 &&
          p.distance.between?(goldilocks_min,goldilocks_max)
        p.life = true
      end
      @planets << p
    end
  end
end
# Giant Star subclass with its own attributes
class GiantStar < Star
  attr_accessor :planets, :chances_of_life, :range_of_planets,
                :goldilocks_min,:goldilocks_max, :recharge_amount

  def initialize
    super
    moreAttributes
    planetGeneration(@range_of_planets,@chances_of_life,
                     @goldilocks_min,@goldilocks_max)
  end

  def moreAttributes
    @chances_of_life = 0.0005
    @range_of_planets = rand(5..10)
    @goldilocks_max = 250
    @goldilocks_min = 100
    @recharge_amount = 2**30
  end
end
# Medium Star subclass with its own attributes
class MediumStar < Star
  attr_accessor :planets, :chances_of_life, :range_of_planets,
                :goldilocks_min,:goldilocks_max, :recharge_amount

  def initialize
    super
    moreAttributes
    planetGeneration(@range_of_planets,@chances_of_life,
                     @goldilocks_min,@goldilocks_max)
  end

  def moreAttributes
    @chances_of_life = 0.0009
    @range_of_planets = rand(2..9)
    @goldilocks_max = 140
    @goldilocks_min = 60
    @recharge_amount = 2**25
  end
end
# Dwarf Star subclass with its own attributes
class DwarfStar < Star
  attr_accessor :planets, :chances_of_life, :range_of_planets,
                :goldilocks_min,:goldilocks_max, :recharge_amount

  def initialize
    super
    moreAttributes
    planetGeneration(@range_of_planets,@chances_of_life,
                     @goldilocks_min,@goldilocks_max)
  end

  def moreAttributes
    @chances_of_life = 0.0006
    @range_of_planets = rand(8..15)
    @goldilocks_max = 90
    @goldilocks_min = 30
    @recharge_amount = 2**20
  end

end