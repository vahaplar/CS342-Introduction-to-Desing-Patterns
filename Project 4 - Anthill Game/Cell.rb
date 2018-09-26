
class Cell
  attr_accessor :food, :hill, :ants
  def initialize
    @hill = false
    @food = 0
    @ants = Array.new()
  end

  def setAntToCell(nant)
    @ants.push(nant)
  end

  def deleteAntAtIndex(nindex)
    @ants.delete_at(nindex)

  end

  def deleteAnt
    @ants.pop()
  end
end