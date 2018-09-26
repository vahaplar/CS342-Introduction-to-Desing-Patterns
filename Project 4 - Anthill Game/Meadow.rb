require 'singleton'
require_relative "Cell"
require_relative "QueenAnt"
require_relative "WariorRoom"
require_relative "BuilderRoom"
require_relative "ForagerRoom"
require 'colorize'

class Meadow
  include Singleton
  @@round_counter =0
  attr_reader :meadow

  def initialize
    @meadow = Array.new(15){Array.new(15)}

    for i in 0..14
      for j in 0..14
        @meadow[i][j] = Cell.new()
      end
    end
  end

  def spawnFood
    for i in 0..2
      @meadow[rand(15)][rand(15)].food += 1
    end
  end

  def showMeadowFood
    for i in 0..14
      for j in 0..14
        puts @meadow[i][j].food
      end
      puts ("\n\n")
    end
  end

  def spawnAntHils
    for i in 1..4
      if (i == 1)
        @meadow = QueenAnt.new().addName("yellow").addLocation(@meadow).build
      elsif (i == 2)
        @meadow = QueenAnt.new().addName("blue").addLocation(@meadow).build
      elsif (i == 3)
        @meadow = QueenAnt.new().addName("red").addLocation(@meadow).build
      else
        @meadow = QueenAnt.new().addName("green").addLocation(@meadow).build
      end
    end
  end

  def spawnAnt
    for i in 0..14
      for j in 0..14
        if (@meadow[i][j].hill)
          name = @meadow[i][j].hill.name

          if(@@round_counter == 0)
            ant = ForagerRoom.new.createAnt(ForagerRoom, name)

            @meadow[i][j].hill.number_of_forager_room -= 1
            @meadow[i][j].hill.ants << ant
            @meadow[i][j].hill.number_of_food -= 1

            ant = WariorRoom.new.createAnt(WariorRoom, name)

            @meadow[i][j].hill.number_of_warrior_room -= 1
            @meadow[i][j].hill.ants << ant
            @meadow[i][j].hill.number_of_food -= 1

            ant = BuilderRoom.new.createAnt(BuilderRoom, name)

            @meadow[i][j].hill.number_of_builder_room -= 1
            @meadow[i][j].hill.builderAnts << ant
            @meadow[i][j].hill.number_of_food -= 1
          end

          while(@meadow[i][j].hill.number_of_food > 0 && @meadow[i][j].hill.getAntNumber < 16)
            if (@meadow[i][j].hill.ant_hill_type == "FireAnt")
              random_ant_type = rand(4)

              if((random_ant_type == 0 || random_ant_type == 1) && @meadow[i][j].hill.number_of_warrior_room > 0)
                ant = WariorRoom.new.createAnt(WariorRoom, name)

                @meadow[i][j].hill.number_of_warrior_room -= 1
                @meadow[i][j].hill.ants << ant
                @meadow[i][j].hill.number_of_food -= 1
              elsif (random_ant_type == 2 && @meadow[i][j].hill.number_of_builder_room > 0)
                ant = BuilderRoom.new.createAnt(BuilderRoom, name)

                @meadow[i][j].hill.number_of_builder_room -= 1
                @meadow[i][j].hill.builderAnts << ant
                @meadow[i][j].hill.number_of_food -= 1
              elsif (random_ant_type == 3 && @meadow[i][j].hill.number_of_forager_room > 0)
                ant = ForagerRoom.new.createAnt(ForagerRoom, name)

                @meadow[i][j].hill.number_of_forager_room -= 1
                @meadow[i][j].hill.ants << ant
                @meadow[i][j].hill.number_of_food -= 1
              end
            elsif (@meadow[i][j].hill.ant_hill_type == "WeaverAnt")
              random_ant_type = rand(4)

              if(random_ant_type == 2 && @meadow[i][j].hill.number_of_warrior_room > 0)
                ant = WariorRoom.new.createAnt(WariorRoom, name)

                @meadow[i][j].hill.number_of_warrior_room -= 1
                @meadow[i][j].hill.ants << ant
                @meadow[i][j].hill.number_of_food -= 1
              elsif ((random_ant_type == 0 || random_ant_type == 1) && @meadow[i][j].hill.number_of_builder_room > 0)
                ant = BuilderRoom.new.createAnt(BuilderRoom, name)

                @meadow[i][j].hill.number_of_builder_room -= 1
                @meadow[i][j].hill.builderAnts << ant
                @meadow[i][j].hill.number_of_food -= 1
              elsif (random_ant_type == 3 && @meadow[i][j].hill.number_of_forager_room > 0)
                ant = ForagerRoom.new.createAnt(ForagerRoom, name)

                @meadow[i][j].hill.number_of_forager_room -= 1
                @meadow[i][j].hill.ants << ant
                @meadow[i][j].hill.number_of_food -= 1
              end
            elsif (@meadow[i][j].hill.ant_hill_type == "HarvesterAnt")
              random_ant_type = rand(4)

              if(random_ant_type == 2 && @meadow[i][j].hill.number_of_warrior_room > 0)
                ant = WariorRoom.new.createAnt(WariorRoom, name)

                @meadow[i][j].hill.number_of_warrior_room -= 1
                @meadow[i][j].hill.ants << ant
                @meadow[i][j].hill.number_of_food -= 1
              elsif (random_ant_type == 3 && @meadow[i][j].hill.number_of_builder_room > 0)
                ant = BuilderRoom.new.createAnt(BuilderRoom, name)

                @meadow[i][j].hill.number_of_builder_room -= 1
                @meadow[i][j].hill.builderAnts << ant
                @meadow[i][j].hill.number_of_food -= 1
              elsif ((random_ant_type == 0 || random_ant_type == 1) && @meadow[i][j].hill.number_of_forager_room > 0)
                ant = ForagerRoom.new.createAnt(ForagerRoom, name)

                @meadow[i][j].hill.number_of_forager_room -= 1
                @meadow[i][j].hill.ants << ant
                @meadow[i][j].hill.number_of_food -= 1
              end
            end
          end
        end
      end
    end
  end

  def moveAntsFromHils
    for i in 0..14
      for j in 0..14
        if (@meadow[i][j].hill)
          hill = @meadow[i][j].hill
          ants = hill.ants

          for k in 0..(ants.length()-1)
            randomNumber = rand(4)
            ant = ants[k]
            randomNumber = checkBorders(i, j, randomNumber)

            if (randomNumber == 0)
              @meadow[i][j+1].setAntToCell(ant)
              @meadow[i][j].deleteAnt()
            elsif (randomNumber == 1)
              @meadow[i][j-1].setAntToCell(ant)
              @meadow[i][j].deleteAnt()
            elsif (randomNumber == 2)
              @meadow[i-1][j].setAntToCell(ant)
              @meadow[i][j].deleteAnt()
            elsif (randomNumber == 3)
              @meadow[i+1][j].setAntToCell(ant)
              @meadow[i][j].deleteAnt()
            end
          end
        end
      end
    end
  end

  def checkBorders(i, j, randomNumber)
    random1 = rand(2)
    random2 = rand(3)

    if(i == 0 && j == 0)
      if (random1 == 0)
        randomNumber = 0
      else
        randomNumber = 3
      end
    elsif (i == 0 && j == 14)
      if (random1 == 0)
        randomNumber = 1
      else
        randomNumber = 3
      end
    elsif (i == 14 && j == 0)
      if (random1 == 0)
        randomNumber = 0
      else
        randomNumber = 2
      end
    elsif (i == 14 && j == 14)
      if (random1 == 0)
        randomNumber = 1
      else
        randomNumber = 2
      end
    elsif (i == 0)
      if (random2 == 0)
        randomNumber = 1
      elsif (random2 == 1)
        randomNumber = 3
      else
        randomNumber = 0
      end
    elsif (i == 14)
      if (random2 == 0)
        randomNumber = 1
      elsif (random2 == 1)
        randomNumber = 2
      else
        randomNumber = 0
      end
    elsif (j == 0)
      if (random2 == 0)
        randomNumber = 2
      elsif (random2 == 1)
        randomNumber = 0
      else
        randomNumber = 3
      end
    elsif (j == 14)
      if (random2 == 0)
        randomNumber = 2
      elsif (random2 == 1)
        randomNumber = 1
      else
        randomNumber = 3
      end
    end
    return randomNumber
  end

  def moveFreeAnts
    for i in 0..14
      for j in 0..14
        for k in 0..@meadow[i][j].ants.length - 1
          random_number = rand(4)
          ant = @meadow[i][j].ants[k]
          random_number = checkBorders(i, j, random_number)

          if (random_number == 0)
            @meadow[i][j+1].setAntToCell(ant)
          elsif (random_number == 1)
            @meadow[i][j-1].setAntToCell(ant)
          elsif (random_number == 2)
            @meadow[i-1][j].setAntToCell(ant)
          elsif (random_number == 3)
            @meadow[i+1][j].setAntToCell(ant)
          end

        end

        for k in 0..@meadow[i][j].ants.length - 1
          @meadow[i][j].deleteAnt

        end
      end
    end
  end


  def checkCollisionForFood
    for i in 0..14
      for j in 0..14
        if (@meadow[i][j].ants.length > 0 && @meadow[i][j].ants[0].type == ForagerRoom && @meadow[i][j].food > 0)
          hill_name = @meadow[i][j].ants[0].hill_name
          cell_food = @meadow[i][j].food

          if (@meadow[i][j].ants[0].experience > 4)
            cell_food = cell_food * 2
          end

          for a in 0..14
            for b in 0..14
              if (@meadow[a][b].hill != false && @meadow[a][b].hill.name == hill_name)
                @meadow[a][b].hill.number_of_food += cell_food
                @meadow[i][j].food = 0
                @meadow[i][j].ants[0].experience += 1
              end
            end
          end
        end
      end
    end
  end

  def checkCollisionsForHill
    for i in 0..14
      for j in 0..14
        ants = @meadow[i][j].ants

        if (ants.length > 0 && ants[0].type == WariorRoom && @meadow[i][j].hill)
          if (ants[0].hill_name != @meadow[i][j].hill)
            if (ants[0].experience < 10)
              random = rand(5)

              if (random == 0)
                killCounter(ants[0].hill_name, "colony")
                @meadow[i][j].hill = false
                ants[0].experience += 5
              end
            else

              kill = false
              for k in 0..ants[0].experience / 10

                if (kill == false)
                  random = rand(5)
                  if (random == 0)
                    killCounter(ants[0].hill_name, "colony")
                    @meadow[i][j].hill = false
                    ants[0].experience += 5
                    kill = true
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  def killCounter(nhillName, nkillType)
    for i in 0..14
      for j in 0..14
        if (@meadow[i][j].hill != false && @meadow[i][j].hill.name == nhillName)
          if (nkillType == "colony")
            @meadow[i][j].hill.colony_kill += 1
          elsif (nkillType == "ant")
            @meadow[i][j].hill.ant_kill += 1
          end
        end
      end
    end
  end

  def checkForagerStatus
    for i in 0..14
      for j in 0..14
        if (@meadow[i][j].hill != false && @meadow[i][j].hill.number_of_food == 0)
          forager_number = 0
          for k in 0..@meadow[i][j].hill.ants.length-1
            if (@meadow[i][j].hill.ants[k].type == ForagerRoom)
              forager_number += 1
            end
          end
        end
        if (forager_number == 0)
          @meadow[i][j].hill = false
        end
      end
    end
  end

  def checkCollisonsForBattle
    for i in 0..14
      for j in 0..14
        ants = @meadow[i][j].ants

        if (ants.length > 1)
          first_ant = ants[0]
          second_ant = ants[1]

          if (first_ant.hill_name != second_ant.hill_name)
            if (first_ant.type == WariorRoom && second_ant.type == WariorRoom)

              if (first_ant.experience == second_ant.experience)
                random = rand(2)

                if (random == 0)
                  hill_name = first_ant.hill_name
                  killAnt(hill_name, WariorRoom)
                  @meadow[i][j].deleteAntAtIndex(0)

                  second_ant.experience += 1
                  killCounter(second_ant.hill_name, "ant")
                else
                  hill_name = second_ant.hill_name
                  killAnt(hill_name, WariorRoom)
                  @meadow[i][j].deleteAntAtIndex(1)

                  first_ant.experience += 1
                  killCounter(first_ant.hill_name, "ant")
                end
              elsif  (first_ant.experience > second_ant.experience)
                experience_difference = first_ant.experience - second_ant.experience
                 kill = false

                for k in 0..experience_difference
                  if (k != experience_difference)
                    random = rand(2)


                    if (random == 0 && kill == false)
                      hill_name = second_ant.hill_name
                      killAnt(hill_name, WariorRoom)
                      @meadow[i][j].deleteAntAtIndex(1)

                      first_ant.experience += 1
                      kill = true
                      killCounter(first_ant.hill_name, "ant")
                    end
                  elsif (k == experience_difference && kill == false)
                    random = rand(2)

                    if (random == 0)
                      hill_name = first_ant.hill_name
                      killAnt(hill_name, WariorRoom)
                      @meadow[i][j].deleteAntAtIndex(0)

                      kill = true
                      second_ant.experience += 1
                      killCounter(second_ant.hill_name, "ant")
                    else
                      hill_name = second_ant.hill_name
                      killAnt(hill_name, WariorRoom)
                      @meadow[i][j].deleteAntAtIndex(1)

                      kill = true
                      first_ant.experience += 1
                      killCounter(first_ant.hill_name, "ant")
                    end
                  end
                end
              else
                experience_difference = second_ant.experience - first_ant.experience
                kill = false

                for k in 0..experience_difference
                  if (k != experience_difference)
                    random = rand(2)


                    if (random == 0 && kill == false)
                      hill_name = first_ant.hill_name
                      killAnt(hill_name, WariorRoom)
                      @meadow[i][j].deleteAntAtIndex(0)

                      second_ant.experience += 1
                      kill = true
                      killCounter(second_ant.hill_name, "ant")
                    end
                  elsif (k == experience_difference && kill == false)
                    random = rand(2)

                    if (random == 0)
                      hill_name = first_ant.hill_name
                      killAnt(hill_name, WariorRoom)
                      @meadow[i][j].deleteAntAtIndex(0)

                      kill = true
                      second_ant.experience += 1
                      killCounter(second_ant.hill_name, "ant")
                    else
                      hill_name = second_ant.hill_name
                      killAnt(hill_name, WariorRoom)
                      @meadow[i][j].deleteAntAtIndex(1)

                      kill = true
                      first_ant.experience += 1
                      killCounter(first_ant.hill_name, "ant")
                    end
                  end
                end
              end
            elsif (first_ant.type == ForagerRoom && second_ant.type == WariorRoom)
              if (second_ant.experience < 5)
                random = rand(2)

                if (random == 0)
                  hill_name = first_ant.hill_name
                  killAnt(hill_name, ForagerRoom)
                  @meadow[i][j].deleteAntAtIndex(0)

                  second_ant.experience += 1
                  killCounter(second_ant.hill_name, "ant")
                end
              else
                kill = false
                for k in 0..second_ant.experience/5
                  if (kill == false)
                    random = rand(2)

                    if (random == 0)
                      hill_name = first_ant.hill_name
                      killAnt(hill_name, ForagerRoom)
                      @meadow[i][j].deleteAntAtIndex(0)

                      second_ant.experience += 1
                      killCounter(second_ant.hill_name, "ant")
                    end
                  end
                end
              end
            elsif (first_ant.type == WariorRoom && second_ant.type == ForagerRoom)
              if (first_ant.experience < 5)
                random = rand(2)

                if (random == 0)
                  hill_name = second_ant.hill_name
                  killAnt(hill_name, ForagerRoom)
                  @meadow[i][j].deleteAntAtIndex(1)

                  first_ant.experience += 1
                  killCounter(first_ant.hill_name, "ant")
                end
              else
                kill = false
                for k in 0..first_ant.experience/5
                  if (kill == false)
                    random = rand(2)

                    if (random == 0)
                      hill_name = second_ant.hill_name
                      killAnt(hill_name, ForagerRoom)
                      @meadow[i][j].deleteAntAtIndex(1)

                      first_ant.experience += 1
                      killCounter(first_ant.hill_name, "ant")
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  def killAnt(nhillName, nantType)
    killed_from_hill = false
    killed_from_cell = false
    for i in 0..14
      for j in 0..14
        if (@meadow[i][j].hill != false && @meadow[i][j].hill.name == nhillName && !killed_from_hill)
          @meadow[i][j].hill.kill(nantType)
          killed_from_hill = true
        end

      end
    end
  end

  def startCycle
    spawnFood
    spawnAntHils
    number_of_colonies = 2
    output_counter = 0

    while(number_of_colonies > 1)
      #sleep(3)
      number_of_colonies = 0
      output_counter += 1

      spawnFood
      spawnAnt
      checkForagerStatus
      moveAntsFromHils
      moveFreeAnts

      checkCollisionForFood
      checkCollisionsForHill
      checkCollisonsForBattle

      @@round_counter += 1
      displayGrid
      output


      buildRoom

      for i in 0..14
        for j in 0..14
          if(@meadow[i][j].hill)
            number_of_colonies += 1
          end
        end
      end
    end
    puts "Game Ended! Last status:"
    displayGrid
    output
  end

  def buildRoom
    for i in 0..14
      for j in 0..14
        if (@meadow[i][j].hill)
          builder_ants = @meadow[i][j].hill.builderAnts

          for k in 1.. builder_ants.length
            ants = @meadow[i][j].hill.ants
            warrior_counter = 0
            forager_counter = 0

            for l in 0..ants.length-1
              if(ants[l].type == WariorRoom)
                warrior_counter += 1
              else
                forager_counter += 1
              end
            end

            @meadow[i][j].hill.builderAntDie
            @meadow[i][j].hill.number_of_builder_room += 1
            if (forager_counter <= warrior_counter)
              @meadow[i][j].hill.number_of_forager_room += 1
            else
              @meadow[i][j].hill.number_of_warrior_room += 1
            end
          end
        end
      end
    end
  end

  def output
    # puts "Round: " + @@round_counter.to_s
    #
    # red_warrior = 0
    # red_forager = 0
    #
    # blue_warrior = 0
    # blue_forager = 0
    #
    # yellow_warrior = 0
    # yellow_forager = 0
    #
    # green_warrior = 0
    # green_forager = 0

    for i in 0..14
      for j in 0..14
        if(@meadow[i][j].hill)
          puts "Anthill Name: " + @meadow[i][j].hill.name
          puts "Anthill Type: " + @meadow[i][j].hill.ant_hill_type

          ants = @meadow[i][j].hill.ants


          # if (@meadow[i][j].ants.length > 0)
          #   for l in 0..@meadow[i][j].ants.length-1
          #     if (@meadow[i][j].ants[l].hill_name == "red")
          #       if (@meadow[i][j].ants[l].type == ForagerRoom)
          #         red_forager += 1
          #       else
          #         red_warrior +=1
          #       end
          #     elsif (@meadow[i][j].ants[l].hill_name == "blue")
          #       if (@meadow[i][j].ants[l].type == ForagerRoom)
          #         blue_forager += 1
          #       else
          #         blue_warrior +=1
          #       end
          #     elsif (@meadow[i][j].ants[l].hill_name == "yellow")
          #       if (@meadow[i][j].ants[l].type == ForagerRoom)
          #         yellow_forager += 1
          #       else
          #         yellow_warrior +=1
          #       end
          #     elsif (@meadow[i][j].ants[l].hill_name == "green")
          #       if (@meadow[i][j].ants[l].type == ForagerRoom)
          #         green_forager += 1
          #       else
          #         green_warrior +=1
          #       end
          #     end
          #   end
          # end


          warrior_counter = 0
          forager_counter = 0

          for k in 0..ants.length-1
            if(ants[k].type == WariorRoom)
              warrior_counter += 1
            else
              forager_counter +=1
            end
          end

          puts("Food: " + @meadow[i][j].hill.number_of_food.to_s)
          puts("Forager Ants: " + forager_counter.to_s)
          puts("Warrior Ants: " + warrior_counter.to_s)
          puts ("builder Ants: " + @meadow[i][j].hill.builderAnts.length.to_s)
          puts("Ant Kill: " + @meadow[i][j].hill.ant_kill.to_s)
          puts("Colony Kill: " + @meadow[i][j].hill.colony_kill.to_s)
          puts("------------------")
        end
      end
    end
    # for i in 0..14
    #   for j in 0..14
    #     if(@meadow[i][j].hill)
    #       puts "Anthill Name: " + @meadow[i][j].hill.name
    #       puts "Anthill Type: " + @meadow[i][j].hill.ant_hill_type
    #
    #       puts("Food: " + @meadow[i][j].hill.number_of_food.to_s)
    #       puts("Ant Kill: " + @meadow[i][j].hill.ant_kill.to_s)
    #       puts("Colony Kill: " + @meadow[i][j].hill.colony_kill.to_s)
    #       puts ("builder Ants: " + @meadow[i][j].hill.builderAnts.length.to_s)
    #
    #       if (@meadow[i][j].hill.name == "red")
    #         puts("Forager Ants: " + red_forager.to_s)
    #         puts("Warrior Ants: " + red_warrior.to_s)
    #       elsif (@meadow[i][j].hill.name == "blue")
    #         puts("Forager Ants: " + blue_forager.to_s)
    #         puts("Warrior Ants: " + blue_warrior.to_s)
    #       elsif (@meadow[i][j].hill.name == "yellow")
    #         puts("Forager Ants: " + yellow_forager.to_s)
    #         puts("Warrior Ants: " + yellow_warrior.to_s)
    #       elsif (@meadow[i][j].hill.name == "green")
    #         puts("Forager Ants: " + green_forager.to_s)
    #         puts("Warrior Ants: " + green_warrior.to_s)
    #       end
    #     end
    #   end
    # end
  end

  def displayGrid
    for i in 0..14
      for line in 0..135
        print ("_").colorize(:color => :black, :background => :white)
      end
      print "\n"
      print "|".colorize(:color => :black, :background => :white)
      for j in 0..14
        counter = 8
        if (@meadow[i][j].hill)
          if (@meadow[i][j].hill != false)
            print "#".colorize(:color => :black, :background => :"#{@meadow[i][j].hill.name}")
            counter -= 1
          else
            print(" ").colorize(:color => :black, :background => :white)
            counter -= 1
          end
        end
        if (@meadow[i][j].ants.length > 0)
          for l in 0..@meadow[i][j].ants.length-1
              if (@meadow[i][j].ants[l].type == ForagerRoom)
                print "~".colorize(:color => :black, :background => :"#{@meadow[i][j].ants[l].hill_name}")
                counter -= 1
              elsif (@meadow[i][j].ants[l].type == WariorRoom)
                print "^".colorize(:color => :black, :background => :"#{@meadow[i][j].ants[l].hill_name}")
                counter -= 1
              else
                print(" ")
              end
          end
        end
        for line_counter in 0..counter - 1
          print" ".colorize(:color => :black, :background => :white)
        end
          #counter.times{(print(" ").colorize(:color => :black, :background => :white))}
        print "|".colorize(:color => :black, :background => :white)
        end
        print "\n"
      end
        for line in 0..135
          print ("_").colorize(:color => :black, :background => :white)
        end
        print "\n"
    end
end