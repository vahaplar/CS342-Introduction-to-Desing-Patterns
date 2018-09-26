require_relative 'APIProxy'
require_relative 'Log'

class RecommendGifProxy < APIProxy
  def initialize(obj)
    @item = obj.getItem
    tag = @item.to_s.split.last
    Log.instance.output(tag)
    @apiKey = "4p27i0AfuXV3mVKh3eKN8oIYUT35cqNC"
    @uri = URI("http://api.giphy.com/v1/gifs/random?api_key=#{@apiKey}&tag=#{tag}")
  end

  def getItem
    begin
      obj = connect(@uri)
      Log.instance.writeHTML("http://giphy.com/embed/#{obj['data']['id']}")
      Log.instance.output("http://giphy.com/embed/#{obj['data']['id']}")
    rescue
      fallback
    end
  end

  def fallback
    puts "API Error! Local GIF will be used."
    Log.instance.writeHTML("gif/dog.gif")
    Log.instance.output("gif/dog.gif")
  end

end