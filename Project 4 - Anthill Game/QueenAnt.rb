require_relative "AntHill"
require_relative "Cell"

class QueenAnt
  attr_reader :name
  def initialize
    @meadow = nil
    @name = nil
    @location = nil
    @ant_hill = nil
    @x_index = nil
    @y_index = nil
  end

  def addLocation(nmeadow)
    @location = true
    @meadow = nmeadow

    while (true)
      @x = rand(15)
      @y = rand(15)

      if not (@meadow[@x][@y].hill)
        @x_index = @x
        @y_index = @y
        break
      end
    end

    return self
  end

  def addName(nname)
    @name = nname
    return self
  end

  def build
    if (@name && @location)
      @ant_hill = AntHill.new(@name)
      @meadow[@x_index][@y_index].hill = @ant_hill
      return @meadow
    end
  end
end