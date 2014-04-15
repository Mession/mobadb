require 'spec_helper'


describe Membership do

  let(:user) { FactoryGirl.create(:user) }
  let(:team) { FactoryGirl.create(:team) }

  describe "when the user is not yet a member" do

    it "is created (not leader)" do
      FactoryGirl.create(:membership, user: user, team: team, team_leader: false)
      expect(Membership.count).to eq(1)
    end

    it "is created (leader)" do
      FactoryGirl.create(:membership, user: user, team: team, team_leader: true)
      expect(Membership.count).to eq(1)
    end

    it "must tell if member is leader or not" do
      FactoryGirl.create(:membership, user: user, team: team, team_leader: nil)
      expect(Membership.count).to eq(1)
    end
  end

  describe "when the user is a normal member" do
    let(:membership) { FactoryGirl.create(:membership, user: user, team: team, team_leader: false) }

    it "wont be created if duplicate (non-leader)" do
      FactoryGirl.create(:membership2, user: user, team: team, team_leader: false)
      expect(Membership.count).to eq(1)
    end

    it "wont be created if duplicate (leader)" do
      FactoryGirl.create(:membership2, user: user, team: team, team_leader: true)
      expect(Membership.count).to eq(1)
    end

    it "can be a second different membership in same team" do
      user2 = FactoryGirl.create(:user2)
      FactoryGirl.create(:membership2, user: user2, team: team, team_leader: false)
      expect(Membership.count).to eq(2)
    end

  end

  describe "when the user is a leader" do
    let(:membership) { FactoryGirl.create(:membership, user: user, team: team, team_leader: true) }

    it "wont be created if duplicate (non-leader)" do
      FactoryGirl.create(:membership2, user: user, team: team, team_leader: false)
      expect(Membership.count).to eq(1)
    end

    it "wont be created if duplicate (leader)" do
      FactoryGirl.create(:membership2, user: user, team: team, team_leader: true)
      expect(Membership.count).to eq(1)
    end

    it "cannot have a second leader" do
      user2 = FactoryGirl.create(:user2)
      FactoryGirl.create(:membership2, user: user2, team: team, team_leader: true)
      expect(Membership.count).to eq(1)
    end

  end

end
