require 'spec_helper'


describe Team do

  it "cannot have an empty name" do
    FactoryGirl.create(:team, name: "")
    expect(Team.count).to eq(0)
  end

  it "must have a game" do
    FactoryGirl.create(:team, game_id: nil)
    expect(Team.count).to eq(0)
  end

  it "cannot have a negative year" do
    FactoryGirl.create(:team, year: -1)
    expect(Team.count).to eq(0)
  end

  it "cannot be from the future" do
    FactoryGirl.create(:team, year: Time.now.year + 1000)
    expect(Team.count).to eq(0)
  end

  it "is created when it has proper values" do
    FactoryGirl.create(:team, max_members: 5)
    expect(Team.count).to eq(1)
  end

  it "is created when it has proper values and unlimited members" do
    FactoryGirl.create(:team)
    expect(Team.count).to eq(1)
  end

  it "cannot have negative max members" do
    FactoryGirl.create(:team, max_members: -1)
    expect(Team.count).to eq(0)
  end

  it "cannot have zero max members" do
    FactoryGirl.create(:team, max_members: 0)
    expect(Team.count).to eq(0)
  end

  it "max members must be atleast 3" do
    FactoryGirl.create(:team, max_members: 2)
    expect(Team.count).to eq(0)
  end
end

