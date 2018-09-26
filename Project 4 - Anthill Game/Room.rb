
class Room
  def createAnt(ntype, nhill)
    room = ntype.new()
    room.newAnt(ntype, nhill)
  end

  def newAnt
    raise NoMethodError.new
  end
end