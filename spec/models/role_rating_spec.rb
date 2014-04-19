require 'spec_helper'

describe RoleRating do

	it "is created when given proper values" do
		rr = FactoryGirl.create(:role_rating)

		expect(RoleRating.count).to eq(1)
	end

	it "cannot be created without a user" do
		rr = FactoryGirl.build(:role_rating, user: nil)

		expect(rr.save).to be(false)
	end	

	it "cannot be created without a role" do
		rr = FactoryGirl.build(:role_rating, role: nil)

		expect(rr.save).to be(false)
	end	

	it "cannot be created without a score" do
		rr = FactoryGirl.build(:role_rating, score: nil)

		expect(rr.save).to be(false)
	end

	it "cannot be created without a game" do
		rr = FactoryGirl.build(:role_rating, game: nil)

		expect(rr.save).to be(false)
	end
	
end
