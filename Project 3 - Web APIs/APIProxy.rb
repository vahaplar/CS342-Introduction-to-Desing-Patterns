require 'net/http'
require 'json'
require 'uri'

class APIProxy

  def initialize
    raise NoMethodError
  end

  def connect(uri)
      proxy = Net::HTTP.get(uri)
      JSON.parse(proxy)
  end

  def getItem
    raise NoMethodError
  end

  def fallback
    raise NoMethodError
  end

end