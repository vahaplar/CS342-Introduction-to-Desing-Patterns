require_relative 'APIProxy'

class RandomUserProxy < APIProxy
attr_accessor
  def initialize
    @uri = URI("https://randomuser.me/api/?id=391K-BPGR-O6K5-7H2Y&nat=us")
  end

  def getItem
    begin
      obj = connect(@uri)
      return obj['results'][0]['location']['state'].to_s
    rescue
      fallback
    end
  end

  def fallback
    puts "API Error. Value set to New York"
    return "New York"
  end

end