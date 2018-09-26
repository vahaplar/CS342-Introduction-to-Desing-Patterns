require_relative '../Gladiator'
# Abstract class
class Arena
  def initialize
    raise NotImplementedMethod
  end
  # Template method
  def init
    race
    puzzle
    battle
  end

  def puzzle
    raise NotImplementedMethod
  end

  def race
    raise NotImplementedMethod
  end

  def battle
    raise NotImplementedMethod
  end

end