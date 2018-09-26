require_relative 'Universe'

class Probe
  attr_reader :x, :y, :z, :fuel, :traveled_distance,
              :visited_stars, :explored_planets

  def initialize(universe)
    # static origin location of probe
    @@origin_x = rand(2**3..2**64) - 1
    @@origin_y = rand(2**3..2**64) - 1
    @@origin_z = rand(2**3..2**64) - 1
    # variables for current location of probe
    @x = @@origin_x
    @y = @@origin_y
    @z = @@origin_z
    # additional information that probe will report back to Earth
    # 2**73 amount of fuel is a threshold value for this probe's algorithm
    # it is discovered by trial & error.It's set to 2**75 so probe won't be lost
    # if fuel is less than 2**73, probe cannot visit all stars in the universe
    # a better algorithm can solve this problem.
    @fuel = 2**75
    @traveled_distance = 0
    @visited_stars = 0
    @explored_planets = 0
    # creating a hash for star objects and their distances to the probe
    @closest_stars = Hash.new
    # storing the values stated above, and sorting them by close to far
    universe.stars.each do |s|
      @closest_stars.store(s, distanceCalculation(@x, @y, @z, s.x, s.y, s.z))
      @closest_stars.values.sort
    end
    # searching for the stars
    searchForStars(universe)
  end
  # probe detects the closest star, sets coordinates, and fuel decreases.
  # it searches until life is found or not. either way it returns to origin
  # if it goes out of fuel in its journey, it cannot report anything.
  def searchForStars(universe)
    puts "Commencing launch sequence... T-minus 5,4,3,2,1 and liftoff!"
    planet_found=0
    # probe moves to the coordinates of each star in the universe
    universe.stars.each { |s|

      current_star = @closest_stars.keys[0]
      distance = @closest_stars.values[0]
      @fuel -= distance
      @x = current_star.x
      @y = current_star.y
      @z = current_star.z
      # if it runs out of fuel, breaks the loop
      if @fuel <= 0
        @fuel = 0
        puts "Probe out of fuel..."
        break
      end
      # if it doesn't, it means it reached to the coordinates
      # probe updates its log for later
      @fuel += current_star.recharge_amount
      @traveled_distance += distance
      @visited_stars += 1
      @explored_planets += current_star.range_of_planets
      # once probe reaches to a star, it scans whole system for life
      # if it finds life, immidately return back to Earth.
      current_star.planets.each{ |p|
        if (p.is_a? HabitablePlanet) && (p.life == true)
          planet_found = 1
          puts "Found life at #{p.id}! Returning..."
          returnToHome
          break
        end
      }
      # probe deletes the star it visited, and heads to the next one
      # it updates its list by his new coordinates and sorts it again
      if planet_found == 1
        break
      else
        @closest_stars.delete(current_star)
        @closest_stars.store(s, distanceCalculation(@x, @y, @z, s.x, s.y, s.z))
        @closest_stars.values.sort
      end
    }
    # this only happens if there's no life in the universe. probe returns
    if @fuel > 0 && planet_found == 0
      puts "There's no other life exists in the universe. Returning..."
      returnToHome
    end

  end
  # probe returns to origin coordinates to inform Earth about its findings
  # it directly comes back so it may go out of fuel.
  # an algorithm to visit a close unvisited star can be implemented to fix this
  def returnToHome
    @traveled_distance += distanceCalculation(@x, @y, @z,
                                              @@origin_x, @@origin_y, @@origin_z)
    @fuel -= distanceCalculation(@x, @y, @z,
                                 @@origin_x, @@origin_y, @@origin_z)
    if @fuel <= 0
      @fuel = 0
      puts 'Probe out of fuel...'
    else
      puts 'We are home...'
      printProbe
    end
  end
  # Probe prints information as soon as arriving the Earth
  def printProbe
    puts "Your origin was (#{@x},#{@y},#{@z})"
    puts "Traveled #{@traveled_distance}"
    puts "Visited #{@visited_stars}"
    puts "Explored #{@explored_planets}"
    puts "Remaining fuel #{@fuel}"
  end
  # calculation of distance between two bodies in the space
  def distanceCalculation(x1, y1, _z1, x2, y2, z2)
    Math.sqrt((x1 - x2)**2 + (y1 - y2)**2 + (y1 - z2)**2)
  end
end