require_relative "Universe"
require_relative "Probe"
# driver code
# universe requires the amount of star
# 2**10 gives optimum results. 2**12 is more realistic
# probe requires the universe
def main()
  c137 = Universe.new(2**10)
  philae = Probe.new(c137)
end
main()