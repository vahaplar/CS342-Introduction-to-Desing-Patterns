require_relative 'Response'
# Base class for Audience
class Audience
  attr_accessor :audience
  # Initializing audience
  def initialize(type)
    setResponseType(type)
  end
  # Update
  def update(event)
    if event == "win"
      @audience.win
    elsif event == "lose"
      @audience.lose
    else
      @audience.harm
    end
  end
  # Set response type according to type
  def setResponseType(type)
    if type == 0
      @audience = Human.new
    elsif type == 1
      @audience = Asura.new
    elsif type == 2
      @audience = Charr.new
    elsif type == 3
      @audience = Norn.new
    elsif type == 4
      @audience = Sylvari.new
    else
      @audience = Skritt.new
    end
  end
end