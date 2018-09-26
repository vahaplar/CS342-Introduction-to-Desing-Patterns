require_relative 'APIProxy'

class PetDetectionProxy < APIProxy
  def initialize(obj)
    @state = obj.getItem
    Log.instance.output(@state.split(/ |\_/).map(&:capitalize).join(" "))
    @apiKey = "6a92069e068cc8446b73d647b285b6c5"
    @uri = URI("http://api.petfinder.com/pet.getRandom?key=#{@apiKey}&animal=dog&location=#{@state}&output=basic&format=json")
  end

  def getItem
    begin
    obj = connect(@uri)
      #if the pet has only one breed specified
      begin
        return obj['petfinder']['pet']['breeds']['breed']['$t']
      #rescue if the pet has more than one breed specified
      rescue
        return obj['petfinder']['pet']['breeds']['breed'][0]['$t']
      end
    rescue
      fallback
    end
  end

  def fallback
    puts "API Error. Value set to Dog"
    return "Dog"
  end
end
