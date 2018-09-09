module SpicyPlants

  class HealthLevel
    HEALTHY = "Healthy"
    AT_RISK = "At Risk"
  end

  class Plant
    attr_reader :plantName, :plantType, :isAlive, :plantHealthLevel, :plantAge

    PLANT_TYPES = ["House"]
    PLANT_ACTIONS = ["Food", "Water", "Light", "Nothing"]

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
      when "Food"
        giveFood
        loseWater
        loseLight
      when "Water"
        giveWater
        loseFood
        loseLight
      when "Light"
        giveLight
        loseWater
        loseFood
      when "Nothing"
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
      when "House"
        @waterLevel = 10
        @sunLevel = 10
        @foodLevel = 10
        @maxSun = 20
        @maxFood = 20
        @maxWater = 20
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