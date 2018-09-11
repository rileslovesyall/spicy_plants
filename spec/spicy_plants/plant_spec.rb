require 'pry'

describe SpicyPlants::Plant do
    before(:each) do
      @housePlant = SpicyPlants::Plant.new("Larry", SpicyPlants::PlantTypes::TOMATO)
      @carniePlant = SpicyPlants::Plant.new("Carnie", SpicyPlants::PlantTypes::PEPPER)
    end

    it "has a name" do
      expect(@housePlant.plantName).to eq("Larry")
      expect(@carniePlant.plantName).to eq("Carnie")
    end

    it "has a type" do
      expect(@housePlant.plantType).to eq(SpicyPlants::PlantTypes::TOMATO)
      expect(@carniePlant.plantType).to eq(SpicyPlants::PlantTypes::PEPPER)
    end

    it "can set Base Stats set for a house plant" do
      expect(@housePlant.instance_variable_get(:@waterLevel)).to eq(10)
      expect(@housePlant.instance_variable_get(:@sunLevel)).to eq(10)
      expect(@housePlant.instance_variable_get(:@foodLevel)).to eq(10)
      expect(@housePlant.instance_variable_get(:@maxSun)).to eq(20)
      expect(@housePlant.instance_variable_get(:@maxWater)).to eq(20)
      expect(@housePlant.instance_variable_get(:@maxFood)).to eq(20)
    end

    it "can set Base Stats for a carnivorous plant" do
      expect(@carniePlant.instance_variable_get(:@waterLevel)).to eq(5)
      expect(@carniePlant.instance_variable_get(:@sunLevel)).to eq(5)
      expect(@carniePlant.instance_variable_get(:@foodLevel)).to eq(2)
      expect(@carniePlant.instance_variable_get(:@maxSun)).to eq(10)
      expect(@carniePlant.instance_variable_get(:@maxWater)).to eq(10)
      expect(@carniePlant.instance_variable_get(:@maxFood)).to eq(4)
    end

    it "can get the health of a Healthy house plant" do
      expect(@housePlant.send :getHealth).to eq(SpicyPlants::HealthLevel::HEALTHY)
    end

    it "can get the health of a Healthy house plant" do
      expect(@housePlant.send :getHealth).to eq(SpicyPlants::HealthLevel::HEALTHY)
    end

    it "can get the health of an At Risk house plant" do
      @housePlant.instance_variable_set(:@waterLevel, 14)
      expect(@housePlant.send :getHealth).to eq(SpicyPlants::HealthLevel::AT_RISK)
    end

    it "can get the health of a Nearly Dead house plant" do
      @housePlant.instance_variable_set(:@waterLevel, 18)
      expect(@housePlant.send :getHealth).to eq(SpicyPlants::HealthLevel::NEARLY_DEAD)
    end



end