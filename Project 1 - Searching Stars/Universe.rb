require_relative 'Star'

class Universe
  attr_reader :stars
  # initializing universe with user designated amount of stars
  def initialize(max_stars)
    # list of stars generated
    @stars = []
    @total_stars = max_stars
    # randomly creating stars around the universe
    (1..max_stars).each do
      type = rand(3)
      s = nil
      if type == 0
        s = GiantStar.new
      elsif type == 1
        s = MediumStar.new
      else
        s = DwarfStar.new
      end
      @stars << s
    end
    # sorting stars for a faster search
    @stars.sort! {|a,b|
      [a.x,a.y,a.z] <=> [b.x,b.y,b.z]
    }
    # we're aware of the universe information (magically)
    printUniverse
  end

  def printUniverse
    # star counters
    giant_stars= 0
    medium_stars= 0
    dwarf_stars= 0
    # planet counters for [giant star, medium star, dwarf star]
    rocky= [0,0,0]
    gaseous = [0,0,0]
    habitable = [0,0,0]
    alive = [0,0,0]
    # for each star, planets randomly created
    # habitable planets has a chance to be inhabited
    # in that case, another counter goes up
    @stars.each {|s|
      if s.is_a? GiantStar
        giant_stars += 1
        s.planets.each{ |p|
          if p.is_a? RockyPlanet
            rocky[0] += 1
          elsif p.is_a? GaseousPlanet
            gaseous[0] += 1
          else
            habitable[0] += 1
            alive[0] += 1 if p.life
          end
        }

      elsif s.is_a? MediumStar
        medium_stars += 1
        s.planets.each{ |p|
          if p.is_a? RockyPlanet
            rocky[1] += 1
          elsif p.is_a? GaseousPlanet
            gaseous[1] += 1
          else
            habitable[1] += 1
            alive[1] += 1 if p.life
          end
        }

      else
        dwarf_stars += 1
        s.planets.each{ |p|
          if p.is_a? RockyPlanet
            rocky[2] += 1
          elsif p.is_a? GaseousPlanet
            gaseous[2] += 1
          else
            habitable[2] += 1
            alive[2] += 1 if p.life
          end
        }
      end
    }
    # information is printed
    puts "Total number of stars in my universe:#{@total_stars}"
    puts "There are #{giant_stars} Giant Stars with:"
    puts "#{gaseous[0]} Gaseous Planets"
    puts "#{rocky[0]} Rocky Planets"
    puts "#{habitable[0]} Habitable Planets"
    puts "#{alive[0]} Planets with Intelligent Life"

    puts "There are #{medium_stars} Medium Stars with:"
    puts "#{gaseous[1]} Gaseous Planets"
    puts "#{rocky[1]} Rocky Planets"
    puts "#{habitable[1]} Habitable Planets"
    puts "#{alive[1]} Planets with Intelligent Life"

    puts "There are #{dwarf_stars} Dwarf Stars with:"
    puts "#{gaseous[2]} Gaseous Planets"
    puts "#{rocky[2]} Rocky Planets"
    puts "#{habitable[2]} Habitable Planets"
    puts "#{alive[2]} Planets with Intelligent Life"
  end
end