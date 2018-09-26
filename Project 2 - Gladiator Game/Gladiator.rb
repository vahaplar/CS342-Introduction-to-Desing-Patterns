require_relative 'Audience'

# Base class for Gladiator
class Gladiator
  attr_reader :speed, :strength, :intelligence, :name
  attr_accessor :health
  # Initializing gladiator with base attributes
  def initialize (name, speed, strength, intelligence, health)
    # Raise error if attributes are wrongly distributed.
    raise ArgumentError.new if speed + strength + intelligence + health > 20

    @name = name
    @speed = speed
    @strength = strength
    @intelligence = intelligence
    @health = health
    @audience = []
  end
  # Register audience
  def register(a)
    @audience << a
  end

  # Deregister audience
  def deregister(a)
    @audience.delete(a)
  end

  # Notify audience
  def notify(event)
    @audience.each do |a|
      a.update(event)
    end
  end
end