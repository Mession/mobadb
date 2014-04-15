require 'spec_helper'


describe Team do

  it "cannot have an empty name" do
    t = FactoryGirl.build(:team, name: "")
    expect(t.save).to be(false)
  end

  it "must have a game" do
    t = FactoryGirl.build(:team, game_id: nil)
    expect(t.save).to be(false)
  end

  it "cannot have a negative year" do
    t = FactoryGirl.build(:team, year: -1)
    expect(t.save).to be(false)
  end

  it "cannot be from the future" do
    t = FactoryGirl.build(:team, year: Time.now.year + 1000)
    expect(t.save).to be(false)
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
    t = FactoryGirl.build(:team, max_members: -1)
    expect(t.save).to be(false)
  end

  it "cannot have zero max members" do
    t = FactoryGirl.build(:team, max_members: 0)
    expect(t.save).to be(false)
  end

  it "max members must be atleast 3" do
    t = FactoryGirl.build(:team, max_members: 2)
    expect(t.save).to be(false)
  end
end

