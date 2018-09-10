describe SpicyPlants::Game do
  let (:game) {SpicyPlants::Game.new}

  it "has plants" do
    expect(game.plants).not_to eq(nil)
  end


end