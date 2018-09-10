describe SpicyPlants::Plant do
    let(:housePlant) {SpicyPlants::Plant.new("Larry", SpicyPlants::PlantTypes::HOUSE)}
    let(:carniePlant) {SpicyPlants::Plant.new("Carnie", SpicyPlants::PlantTypes::CARNIVOROUS)}

    it "has a name" do
      expect(housePlant.plantName).to eq("Larry")
      expect(carniePlant.plantName).to eq("Carnie")
    end

    it "has a type" do
      expect(housePlant.plantType).to eq(SpicyPlants::PlantTypes::HOUSE)
      expect(carniePlant.plantType).to eq(SpicyPlants::PlantTypes::CARNIVOROUS)
    end

    it "can set Base Stats set for a house plant" do
      expect(housePlant.instance_variable_get(:@waterLevel)).to eq(10)
      expect(housePlant.instance_variable_get(:@sunLevel)).to eq(10)
      expect(housePlant.instance_variable_get(:@foodLevel)).to eq(10)
      expect(housePlant.instance_variable_get(:@maxSun)).to eq(20)
      expect(housePlant.instance_variable_get(:@maxWater)).to eq(20)
      expect(housePlant.instance_variable_get(:@maxFood)).to eq(20)
    end

    it "can set Base Stats for a carnivorous plant" do
      expect(carniePlant.instance_variable_get(:@waterLevel)).to eq(5)
      expect(carniePlant.instance_variable_get(:@sunLevel)).to eq(5)
      expect(carniePlant.instance_variable_get(:@foodLevel)).to eq(2)
      expect(carniePlant.instance_variable_get(:@maxSun)).to eq(10)
      expect(carniePlant.instance_variable_get(:@maxWater)).to eq(10)
      expect(carniePlant.instance_variable_get(:@maxFood)).to eq(4)
    end


end