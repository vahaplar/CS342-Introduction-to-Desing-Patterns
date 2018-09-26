
class AntHill
  attr_accessor :ants, :number_of_food, :number_of_warrior_room, :number_of_builder_room, :number_of_forager_room
  attr_accessor :colony_kill, :ant_kill, :builderAnts
  attr_reader :name, :ant_hill_type
  def initialize(name)
    @temp = rand(3)

    if(@temp == 0)
      @ant_hill_type = "FireAnt"
    elsif (@temp == 1)
      @ant_hill_type = "WeaverAnt"
    else
      @ant_hill_type = "HarvesterAnt"
    end

    @name = name
    @number_of_food = 5

    @number_of_warrior_room = 5
    @number_of_builder_room = 5
    @number_of_forager_room = 5

    @ants = Array.new()
    @builderAnts = Array.new()

    @ant_kill = 0
    @colony_kill = 0
  end

  def kill(ntype)
    for i in 0..@ants.length-1
      if (@ants[i].type == ntype)
        @ants.delete_at(i)
        break
      end
    end
  end

  def addLength
    puts @name
    puts @ants.length.to_s
    puts @builderAnts.length.to_s
  end

  def builderAntDie
    @builderAnts.pop()
  end

  def getAntNumber
    return @ants.length + @builderAnts.length
  end
end