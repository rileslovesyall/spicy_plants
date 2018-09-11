require 'pry'

 module SpicyPlants
  class Game
    attr_accessor :plants

    def initialize()
      @plants = []
      @newPlantCounter = 0
      @harvestablePlants = 0
    end

    def play
      addPlant
      while !gameLost?
        takeTurn
      end
      puts "Womp womp, all your plants died. Better luck next time, friendo."
    end

    private

    def takeTurn
      for plant in @plants do
        if !plant.isHarvestable?
          puts "-------------------------------------"
          puts ""
          puts "Time to check on #{plant.plantName}!"
          puts ""
          puts "What would you like to give your #{plant.plantType} plant?"
          action = gets.chomp.capitalize

          while !SpicyPlants::Plant::PLANT_ACTIONS.include?(action)
            puts "I don't think that's something you can do with a plant."
            puts "How about you pick from the following list of choices:"
            puts "#{SpicyPlants::Plant::PLANT_ACTIONS}"
            action = gets.chomp
          end
          plant.takeAction(action)
          puts ""
          puts "Alright, you have given #{plant.plantName} the #{plant.plantType} plant #{action} this turn."
          puts ""
          puts "#{plant.plantName}'s current health level is: #{plant.plantHealthLevel}"
          puts "#{plant.plantName} has survived for #{plant.plantAge} days!"
          puts ""

          ifDeadDelete(plant)
          harvestPlant(plant) if plant.isAlive && plant.isHarvestable?
          offerUserNewPlant if plant.isAlive
          readyToEat
        end
      end
    end

    def readyToEat
      if @plants.length === @harvestablePlants
        puts "You won! All your plants are ready to go!"
        puts "Get on in the kitchen & make some yummers for yr tummers!"
      end
    end

    def ifDeadDelete(plant)
      if !plant.isAlive
        @plants.delete(plant) 
        puts "Oh no, you killed #{plant.plantName} after #{plant.plantAge} days!"
        puts "This was a living thing. Try harder next time, eh?"
      end
    end

    def harvestPlant(plant)
      puts "Ooooeeeee, your #{plant.plantType} plant is harvestable!"
      puts "Let's get it outta the garden and into your pantry!"
      @harvestablePlants += 1
    end

    def offerUserNewPlant
      if @newPlantCounter > 8
        puts "Would you like to add another plant to your collection? (y/n)"
        answer = gets.chomp
        case answer
        when "y"
          addPlant
        when "n" 
          puts "Fair enough, plants are a lot of responsibility & life is hard enough as it is."
        else 
          puts "I'm not sure what you meant. Please select 'y' or 'n'"
        end
        @newPlantCounter = 0
      end
      @newPlantCounter += 1
    end

    def addPlant()
      puts ""
      puts "--------------------------------------"
      puts ""
      puts "What type of plant would you like today?"
      puts "Your currently available options are: #{SpicyPlants::Plant::PLANT_TYPES}"

      plantType = gets.chomp.capitalize
      puts ""

      while !SpicyPlants::Plant::PLANT_TYPES.include?(plantType) do
        puts "Hmm, that's not a valid plant type."
        puts "Please choose from the following list: #{SpicyPlants::Plant::PLANT_TYPES}"
        plantType = gets.chomp
        puts ""
      end

      puts "Great, now let's give a name to your #{plantType} plant."
      puts "What would you like to call it?"

      plantName = gets.chomp

      @plants.push(SpicyPlants::Plant.new(plantName, plantType))
      puts ""
      puts "Congratulations, you've got a new plant."
      puts "Meet #{plantName} the #{plantType} plant."
      puts "Be sure to take good care of them, now."
      puts ""
    end

    def gameLost?
      return @plants.empty?
    end

  end
end