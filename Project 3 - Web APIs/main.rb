require_relative 'APIProxy'
require_relative 'RandomUserProxy'
require_relative 'PetDetectionProxy'
require_relative 'RecommendGifProxy'
require_relative 'Log'

def main
  RecommendGifProxy.new(PetDetectionProxy.new(RandomUserProxy.new)).getItem
end
main()