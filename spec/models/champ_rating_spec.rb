require 'spec_helper'

describe ChampRating do

	it "is created when given proper values" do
		cr = FactoryGirl.create(:champ_rating)

		expect(ChampRating.count).to eq(1)
	end

	it "cannot be created without a user" do
		cr = FactoryGirl.build(:champ_rating, user: nil)

		expect(cr.save).to be(false)
	end	

	it "cannot be created without a champion" do
		cr = FactoryGirl.build(:champ_rating, champion: nil)

		expect(cr.save).to be(false)
	end	

	it "cannot be created without a score" do
		cr = FactoryGirl.build(:champ_rating, score: nil)

		expect(cr.save).to be(false)
	end

	it "has a game (through champion) when created with proper values" do
		cr = FactoryGirl.create(:champ_rating)

		expect(cr.game).to_not be(nil)
	end

	it "is not created when ratings champion doesnt have a game value" do
		champ = FactoryGirl.build(:champion, game: nil)
		champ.save(validate: false)

		cr = FactoryGirl.build(:champ_rating, champion: champ)

		expect(cr.save).to be(false)
	end
	
end
