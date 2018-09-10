module SpicyPlants

  class HealthLevel
    HEALTHY = "Healthy"
    AT_RISK = "At Risk"
    NEARLY_DEAD = "Nearly Dead"
  end

  class PlantActions
    FOOD = "Food"
    WATER = "Water"
    LIGHT = "Light"
    NOTHING = "Nothing"
  end

  class PlantTypes
    HOUSE = "House"
    CARNIVOROUS = "Carnivorous"
  end

  class Plant
    attr_reader :plantName, :plantType, :isAlive, :plantHealthLevel, :plantAge

    PLANT_TYPES = [SpicyPlants::PlantTypes::HOUSE]
    PLANT_ACTIONS = [
      SpicyPlants::PlantActions::FOOD, 
      SpicyPlants::PlantActions::WATER, 
      SpicyPlants::PlantActions::LIGHT, 
      SpicyPlants::PlantActions::NOTHING
    ]

    def initialize(plantName, plantType)
      @plantName = plantName
      @plantType = plantType
      @isAlive = true
      @plantAge = 0

      setBaseStats(@plantType)
      getHealth()

    end

    def takeAction(action)
      case action
      when SpicyPlants::PlantActions::FOOD
        giveFood
        loseWater
        loseLight
      when SpicyPlants::PlantActions::WATER
        giveWater
        loseFood
        loseLight
      when SpicyPlants::PlantActions::LIGHT
        giveLight
        loseWater
        loseFood
      when SpicyPlants::PlantActions::NOTHING
        loseFood
        loseWater
        loseLight
      end
      @plantAge += 1
      getHealth()
    end

    private

    def setBaseStats(plantType)
      case plantType
      when SpicyPlants::PlantTypes::HOUSE
        @waterLevel = 10
        @sunLevel = 10
        @foodLevel = 10
        @maxSun = 20
        @maxFood = 20
        @maxWater = 20
      when SpicyPlants::PlantTypes::CARNIVOROUS
        @waterLevel = 5
        @sunLevel = 5
        @foodLevel = 2
        @maxSun = 10
        @maxFood = 4
        @maxWater = 10
      end
      @foodRange = @maxFood/2
      @waterRange = @maxWater/2
      @sunRange = @maxSun/2
    end

    def giveWater 
      @waterLevel += 1
    end

    def giveFood
      @foodLevel += 1
    end

    def giveLight
      @sunLevel += 1
    end

    def loseWater
      @waterLevel -= 1
    end

    def loseFood
      @foodLevel -= 1
    end

    def loseLight 
      @sunLevel -= 1
    end

    def getHealth
      if (@foodLevel === @maxFood ||
        @waterLevel === @maxWater ||
        @sunLevel === @maxSun ||
        @foodLevel === 0 ||
        @waterLevel === 0 ||
        @sunLevel === 0)
        @isAlive = false
        @plantHealthLevel = SpicyPlants::HealthLevel::AT_RISK
      end

      foodDamage = (@foodRange - @foodLevel).abs
      waterDamage = (@waterRange - @waterLevel).abs
      sunDamage = (@sunRange - @sunLevel).abs

      healthLevel = SpicyPlants::HealthLevel::HEALTHY
      if (foodDamage > @foodRange/2 || 
        waterDamage > @waterRange/2 ||
        sunDamage > @sunRange/2)
        healthLevel = SpicyPlants::HealthLevel::AT_RISK
      end
      @plantHealthLevel = healthLevel
    end

  end 
end